terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  location_suffix = replace(lower(var.azure_location), " ", "")
  common_name     = "${var.project_name}-${var.environment}-${local.location_suffix}"

  global_tags = {
    Managed_by  = "Terraform"
      Team        = var.team
      Owner       = var.owner
      Project     = var.project_name
      Environment = var.environment
  }
}

resource "azurerm_resource_group" "main-group" {
  name     = "${local.common_name}-rg"
  location = var.azure_location

  tags = local.global_tags
}

module "network" {
  source = "../../modules/network"

  common_name        = local.common_name
  availability_zones = var.availability_zones

  location       = azurerm_resource_group.main-group.location
  resource_group = azurerm_resource_group.main-group.name

  vnet_ip_range       = var.vnet_ip_range
  team_authorized_ips = var.team_authorized_ips

  allow_ssh_access   = var.allow_ssh_access
  allow_http_access  = var.allow_http_access
  http_public_access = var.http_public_access

  tags = local.global_tags
}

module "vm" {
  source = "../../modules/vm"

  common_name        = local.common_name
  availability_zones = var.availability_zones

  location       = azurerm_resource_group.main-group.location
  resource_group = azurerm_resource_group.main-group.name

  instance_size         = var.instance_size
  username              = var.username
  public_key_path       = var.public_key_path
  network_interface_ids = module.network.network_interface_ids

  tags = local.global_tags
}
