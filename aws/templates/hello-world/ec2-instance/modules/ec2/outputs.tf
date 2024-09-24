output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this[*].id
}

output "server_public_ip" {
  description = "Public IP adress of the EC2 Instance"
  value = aws_instance.this[*].public_ip
}

output "server_public_dns" {
  description = "Public DNS of the EC2 Instance"
  value = aws_instance.this[*].public_dns
}