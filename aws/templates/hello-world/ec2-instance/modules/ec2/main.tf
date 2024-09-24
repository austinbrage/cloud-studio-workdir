resource "aws_instance" "this" {
  ami           = var.ami_id
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

  tags = merge(var.tags, {
    Name = "${var.project_name}_${var.environment}_ec2_${count.index + 1}"
    Project = var.project_name
    Environment = var.environment
  })
}
