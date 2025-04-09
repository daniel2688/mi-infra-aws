resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.amzn_linx.id
  instance_type               = var.instancetype
  key_name                    = "public-key" # Reemplaza con tu clave pública
  count                       = 1
  iam_instance_profile        = aws_iam_instance_profile.role_profile.name
  subnet_id                   = aws_subnet.public[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_tls_ipv4.id]

  tags = {
    Name = "${var.ec2_names[count.index]}" # Usa el nombre de la lista de nombres de instancias
  }

  depends_on = [aws_iam_role.ssm_access, aws_iam_policy_attachment.attachment]

  lifecycle {
    ignore_changes = [ tags ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user" # Cambia si usas otro usuario
      private_key = file("/mnt/c/Users/LENOVO/Downloads/public-key.pem") # Asegúrate de tener tu clave privada configurada correctamente
      host        = self.public_ip
    }
  }

  # lifecycle {
  #   create_before_destroy = true
  # }

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_iam_instance_profile" "role_profile" {
  name = "SSMFullAccessProfile"
  role = aws_iam_role.ssm_access.name
}

resource "aws_iam_role" "ssm_access" {
  name = upper(join("-", ["SSMFullAccessRole", "ec2"])) # Nombre del rol
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "attachment" {
  name       = "my-ssm-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess" # Asegúrate de que este ARN sea el correcto
  roles      = [aws_iam_role.ssm_access.name]
}

