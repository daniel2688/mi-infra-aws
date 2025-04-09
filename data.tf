# Data source to get the latest Amazon Linux 2 AMI ID

data "aws_ami" "amzn_linx" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"] # Para Amazon Linux 2
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
