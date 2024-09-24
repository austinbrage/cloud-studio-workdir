output "ec2_server_public_ip" {
  description = "Public IP adress of the EC2 Instance"
  value       = module.ec2.public_ip
}

output "ec2_server_private_ip" {
  description = "Private IP adress of the EC2 Instance"
  value       = module.ec2.private_ip
}