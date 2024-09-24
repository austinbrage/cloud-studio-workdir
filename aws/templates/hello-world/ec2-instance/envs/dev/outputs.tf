output "ec2_server_public_ip" {
  description = "Public IP adress of the EC2 Instance"
  value       = module.ec2.server_public_ip
}

output "ec2_server_public_dns" {
  description = "Public DNS of the EC2 Instance"
  value       = module.ec2.server_public_dns
}
