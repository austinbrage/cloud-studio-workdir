locals {
  ami_filters = {
    amazon_linux = {
      name                = "al2023-ami-2023*"
      owner               = "amazon"
      virtualization_type = "hvm"
    }
    ubuntu = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      owner               = "099720109477"
      virtualization_type = "hvm"
    }
    debian = {
      name                = "debian-10-amd64-*"
      owner               = "136693071363"
      virtualization_type = "hvm"
    }
  }
}

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

resource "aws_instance" "this" {
  ami           = var.ami_id != null ? var.ami_id : data.aws_ami.selected_ami.id
  count         = var.instance_count
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  
  user_data = var.user_data

  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = false
  }

  tags = merge(var.common_tags, var.tags, {
    Name = "${var.project_name}_${var.environment}_ec2_${count.index + 1}"
    Project = var.project_name
    Environment = var.environment
  })
}
