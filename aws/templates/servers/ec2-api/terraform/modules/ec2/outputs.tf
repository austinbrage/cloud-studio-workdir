output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = var.instance_count != 0 ? aws_instance.main[*].id : null
}

output "public_ip" {
  description = "The public IP address of the instance."
  value       = var.instance_count != 0 ? aws_instance.main[*].public_ip : null
}

output "private_ip" {
  description = "The private IP address of the instance."
  value       = var.instance_count != 0 ? aws_instance.main[*].private_ip : null
}

output "key_pair_id" {
  description = "The ID of the key pair"
  value       = var.create_key_pair ? aws_key_pair.main[0].id : var.key_name
}

output "key_pair_name" {
  description = "The NAME of the key pair"
  value       = var.create_key_pair ? aws_key_pair.main[0].key_name : var.key_name
}

output "ami_username" {
  description = "The username associated with the selected AMI type."
  value       = local.ami_filters[var.ami_type].username
}