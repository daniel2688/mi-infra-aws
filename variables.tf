variable "region" {
  description = "Región de despliegue"
  type        = string
}

variable "tags" {
  description = "Tags para los recursos de AWS"
  type        = map(string)
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "project" {
  description = "Proyecto de despliegue"
  type        = string
}

variable "managedby" {
  description = "Herramienta de IaC utilizada"
  type        = string
}

variable "public_subnets" {
  description = "Subredes públicas"
  type = list(object({
    cidr_block        = string
    availability_zone = string
    name_key          = string # Clave para buscar el nombre en `local.subnet_names`.
  }))
}

variable "private_subnets" {
  description = "Subredes privadas"
  type = list(object({
    cidr_block        = string
    availability_zone = string
    name_key          = string # Clave para buscar el nombre en `local.subnet_names`.
  }))
}

variable "instancetype" {
  description = "Tipo de instancia EC2"
  type        = string
}

variable "ec2_names" {
  type    = list(string)
  default = ["ec2-instance-1", "ec2-instance-2", "ec2-instance-3"]
}

variable "sub_public" {
  description = "Subredes públicas"
  type        = string
  default     = "subnet-public" # Clave para `local.subnet_names`.
  
}

variable "sub_private" {
  description = "Subredes privadas"
  type        = string
  default     = "subnet-private" # Clave para `local.subnet_names`.
}