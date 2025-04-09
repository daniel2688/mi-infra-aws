# This file is used to define local variables that are used throughout the Terraform configuration.

locals {
  name_prefix = "${var.environment}-${var.project}" # Prefijo común para todos los nombres.

  # Nombre de vpc    
  vpc_name = "vpc-${local.name_prefix}"

  # Nombre de instancias
  instance_name = "ec2-${local.name_prefix}"

  # Nombre de igw
  igw_name = "igw-${local.name_prefix}"

  # Nombres de subredes
  subnet_names = {
    public_1  = "${var.sub_public}-1-${local.name_prefix}"
    public_2  = "${var.sub_public}-2-${local.name_prefix}"
    private_1 = "${var.sub_private}-1-${local.name_prefix}"
    private_2 = "${var.sub_private}-2-${local.name_prefix}"
    private_3 = "${var.sub_private}-3-${local.name_prefix}"
    private_4 = "${var.sub_private}-4-${local.name_prefix}"
  }

  # Nombres de tablas de rutas
  route_table_names = {
    public_1  = "rt-public-${local.name_prefix}"
    private_1 = "rt-private-${local.name_prefix}"
  }

  # Nombres de grupos de seguridad
  security_group_names = {
    public = "sg_public_${var.environment}_${var.project}"
  }

  # Puertos permitidos
  ingress_ports = [80, 8080, 443, 9090, 22] # Puertos permitidos para el grupo de seguridad.
}

