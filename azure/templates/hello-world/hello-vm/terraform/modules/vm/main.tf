resource "azurerm_linux_virtual_machine" "main-vm" {
  name                = "${var.common_name}-vm"
  resource_group_name = var.resource_group
  location            = var.location

  size                  = var.instance_size
  admin_username        = var.username
  network_interface_ids = var.network_interface_ids

  admin_ssh_key {
    username   = "adminuser"
    public_key = file(var.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = var.tags
}

