output "current_location" {
  description = "The current location configured on the Azure provider."
  value       = var.azure_location
}

output "username" {
  description = "Username of the VM Instance."
  value       = var.username
}

output "public_ip" {
  description = "Public IP adress of the VM Instance."
  value       = module.vm.public_ip
}