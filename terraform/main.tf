resource "aws_instance" "minio_server" {
  ami               = "ami-0f3f2cef1fc7d0edb"
  instance_type     = var.instance_type
  
  # ВОТ ЭТА МАГИЧЕСКАЯ СТРОЧКА:
  availability_zone = var.availability_zone 

  user_data = file("install_minio.sh")
  
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.minio_sg.id]
  key_name               = var.key_name

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name    = "MinIO-Production"
    Project = "minio-aws"
    Owner   = "Eleonora"
  }
}

output "instance_public_ip" {
  value = aws_instance.minio_server.public_ip
}

terraform {
  backend "s3" {}
}