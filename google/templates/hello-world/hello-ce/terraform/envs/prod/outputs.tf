output "username" {
  description = "Username of the CE instance"
  value       = module.vm.username
}

output "public_ip" {
  description = "Public IP adress of the CE instance"
  value       = module.vm.public_ip
}