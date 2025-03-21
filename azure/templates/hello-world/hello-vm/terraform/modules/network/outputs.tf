output "network_interface_ids" {
  description = "The list of network interface IDs."
  value       = [azurerm_network_interface.main_nic.id]
}