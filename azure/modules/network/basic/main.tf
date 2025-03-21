resource "azurerm_virtual_network" "main_vn" {
  name                = "${var.common_name}-vnet"
  resource_group_name = var.resource_group
  location            = var.location
  address_space       = [var.vnet_ip_range]

  tags = var.tags
}

resource "azurerm_subnet" "main-subnet" {
  name                 = "${var.common_name}-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.main_vn.name
  address_prefixes     = [cidrsubnet(var.vnet_ip_range, 8, 1)]
}

resource "azurerm_network_security_group" "main-sg" {
  name                = "${var.common_name}-nsg"
  resource_group_name = var.resource_group
  location            = var.location

  tags = var.tags
}

resource "azurerm_network_security_rule" "allow-ssh" {
  count = var.allow_ssh_access ? 1 : 0

  name                        = "${var.common_name}-allow-ssh"
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.main-sg.name

  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefixes    = var.team_authorized_ips
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "allow-http" {
  count = var.allow_http_access ? 1 : 0

  name                        = "${var.common_name}-allow-http"
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.main-sg.name

  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefixes    = var.http_public_access ? ["0.0.0.0/0"] : var.team_authorized_ips
  destination_address_prefix = "*"
}

resource "azurerm_subnet_network_security_group_association" "main-sg-association" {
  subnet_id                 = azurerm_subnet.main-subnet.id
  network_security_group_id = azurerm_network_security_group.main-sg.id
}

resource "azurerm_public_ip" "main-ip" {
  name                = "${var.common_name}-pip"
  resource_group_name = var.resource_group
  location            = var.location

  allocation_method = "Dynamic"
  sku               = "Basic"

  tags = var.tags
}

resource "azurerm_network_interface" "main_nic" {
  name                = "${var.common_name}-nic"
  resource_group_name = var.resource_group
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main-ip.id
  }

  tags = var.tags
}