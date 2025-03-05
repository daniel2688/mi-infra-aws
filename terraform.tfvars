region = "us-east-1"

tags = {
  "project"     = "cloudops"
  "environment" = "dev"
  "creation"    = "2025"
  "managedby"   = "terraform"
}

environment = "dev"
project     = "cloudops"
managedby   = "terraform"

public_subnets = [
  {
    cidr_block        = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    name_key          = "public_1"
  },
  {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    name_key          = "public_2"
  }
]

private_subnets = [
  {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    name_key          = "private_1"
  },
  {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1b"
    name_key          = "private_2"
  },
  {
    cidr_block        = "10.0.4.0/24"
    availability_zone = "us-east-1a"
    name_key          = "private_3"
  },
  {
    cidr_block        = "10.0.5.0/24"
    availability_zone = "us-east-1b"
    name_key          = "private_4" # Clave para `local.subnet_names`.
  }
]