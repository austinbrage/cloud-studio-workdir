output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = var.instance_count != 0 ? aws_instance.this[*].id : null
}

output "public_ip" {
  description = "The public IP address of the instance."
  value       = var.instance_count != 0 ? aws_instance.this[*].public_ip : null
}

output "private_ip" {
  description = "The private IP address of the instance."
  value       = var.instance_count != 0 ? aws_instance.this[*].private_ip : null
}