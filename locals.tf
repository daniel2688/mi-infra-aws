locals {
    name_prefix = "${var.environment}-${var.project}"  # Prefijo común para todos los nombres.

  # Nombre de vpc    
    vpc_name = "vpc-${local.name_prefix}"

  # Nombre de igw
    igw_name = "igw-${local.name_prefix}"

  # Nombres de subredes
  subnet_names = {
    public_1  = "subnet-public-1-${local.name_prefix}"
    public_2  = "subnet-public-2-${local.name_prefix}"
    private_1 = "subnet-private-1-${local.name_prefix}"
    private_2 = "subnet-private-2-${local.name_prefix}"
    private_3 = "subnet-private-3-${local.name_prefix}"
    private_4 = "subnet-private-4-${local.name_prefix}"
  }

  # Nombres de tablas de rutas
  route_table_names = {
    public_1  = "rt-public-${local.name_prefix}"
    private_1 = "rt-private-${local.name_prefix}"
  }
}


