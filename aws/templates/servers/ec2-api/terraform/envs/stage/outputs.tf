output "public_ip" {
  description = "Public IP adress of the EC2 Instance."
  value       = module.ec2.public_ip
}

output "private_ip" {
  description = "Private IP adress of the EC2 Instance."
  value       = module.ec2.private_ip
}

output "username" {
  description = "Username of the OS on the EC2 Instance."
  value       = module.ec2.ami_username
}

output "key_pair_name" {
  description = "Name of the key pair on the EC2 Intance."
  value       = module.ec2.key_pair_name
}
