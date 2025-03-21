output "public_ip" {
  description = "The public IP address of the Linux VM from the network interface."
  value       = azurerm_linux_virtual_machine.main-vm.public_ip_address
}