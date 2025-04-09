# Creacion de vpc en AWS
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # Define el bloque CIDR para el VPC.

  tags = {
    Name = local.vpc_name # Asigna el nombre del VPC usando una etiqueta.
  }
}

# Creacion de Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = local.igw_name # Asigna el nombre del Internet Gateway usando una etiqueta.
  }
}

# Subredes públicas
resource "aws_subnet" "public" {
  for_each = { for idx, subnet in var.public_subnets : idx => subnet }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true # Solo para subredes públicas.

  tags = {
    Name = local.subnet_names[each.value.name_key] # Usa la clave para obtener el nombre.
  }
}

# Subredes privadas
resource "aws_subnet" "private" {
  for_each = { for idx, subnet in var.private_subnets : idx => subnet }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  # map_public_ip_on_launch no se define (por defecto es false).

  tags = {
    Name = local.subnet_names[each.value.name_key] # Usa la clave para obtener el nombre.
  }
}

# Tabla de rutas pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = local.route_table_names["public_1"] # Usa la clave para obtener el nombre.
  }
}

# Ruta para permitir el acceso a Internet desde las subredes públicas
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"                  # Tráfico destinado a cualquier dirección IP.
  gateway_id             = aws_internet_gateway.main.id # Usa el Internet Gateway creado anteriormente.
}

# Tabla de rutas privada
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = local.route_table_names["private_1"] # Usa la clave para obtener el nombre.
  }
}

# Asociaciones de tablas de rutas para subredes públicas
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Asociaciones de tablas de rutas para subredes privadas
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

# Grupo de seguridad
resource "aws_security_group" "allow_tls_ipv4" {
  name        = local.security_group_names["public"]
  description = "Permite trafico en los puertos indicados"
  vpc_id      = aws_vpc.main.id

  # Dynamic block para las reglas de ingreso
  dynamic "ingress" {
    for_each = local.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  # Reglas de egreso (opcional)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}