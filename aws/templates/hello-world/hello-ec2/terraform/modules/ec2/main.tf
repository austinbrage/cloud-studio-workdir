data "aws_ami" "selected_ami" {
  most_recent = true
  owners      = [local.ami_filters[var.ami_type].owner]

  filter {
    name   = "name"
    values = [local.ami_filters[var.ami_type].name]
  }

  filter {
    name   = "virtualization-type"
    values = [local.ami_filters[var.ami_type].virtualization_type]
  }
}

locals {
  ami_filters = {
    amazon_linux = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      owner               = "amazon"
      virtualization_type = "hvm"
      username            = "ec2-user"
    }
    ubuntu = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      owner               = "099720109477"
      virtualization_type = "hvm"
      username            = "ubuntu"
    }
    debian = {
      name                = "debian-10-amd64-*"
      owner               = "136693071363"
      virtualization_type = "hvm"
      username            = "admin"
    }
  }

  unique_key_name = format("%s-%s", var.common_name, random_string.key_name.result)
}

locals {
  ami_username   = var.ami_id != null ? "ec2-user" : local.ami_filters[var.ami_type].username
  final_key_name = var.create_key_pair == false ? var.key_name : local.unique_key_name
}

resource "random_string" "key_name" {
  length  = 8
  upper   = false
  special = false
}

resource "aws_key_pair" "main" {
  count      = var.create_key_pair ? 1 : 0
  key_name   = local.final_key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "main" {
  ami                    = var.ami_id != null ? var.ami_id : data.aws_ami.selected_ami.id
  count                  = var.instance_count
  instance_type          = var.instance_type
  key_name               = local.final_key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  associate_public_ip_address = true

  tags = {
    Name = "${var.common_name}-ec2-${count.index + 1}"
  }
}
