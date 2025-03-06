terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {                     # Sección donde se define el proveedor requerido (en este caso, AWS).
      source  = "hashicorp/aws" # Especifica que el proveedor AWS será descargado desde HashiCorp Registry.
      version = ">= 5.89"       # Define que se usará la versión 5.89 o superior del proveedor AWS.
    }
  }
}

provider "aws" {
  region = var.region # Define la región de AWS donde se desplegarán los recursos (en este caso, "us-east-1").
  # profile = var.tags["profile"] # Indica el perfil de AWS a usar. Este perfil debe estar configurado previamente en tu archivo de credenciales de AWS (~/.aws/credentials).
  #   alias   = "virginia"          # Define un alias para el proveedor. Este alias se usará para referenciar este proveedor en otros recursos.

  default_tags { # Define los tags que se aplicarán a todos los recursos creados por este proveedor.
    tags = {
      Project     = var.tags["project"]
      Environment = var.tags["environment"]
      Creation    = var.tags["creation"]
      ManagedBy   = var.tags["managedby"]
    }
  }
}