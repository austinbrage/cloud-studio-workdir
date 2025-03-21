# AZURE Network Terraform module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)

This Terraform module creates essential networking resources in AZURE, including a Virtual Network (VNet), subnet, Network Security Group (NSG), security rules, a public IP, and a network interface.  

## Features  

- Creates a VNet with a configurable CIDR range.  
- Defines a subnet within the VNet.  
- Configures a Network Security Group with dynamic ingress and egress rules.
- Creates a public IP with dynamic allocation and a network interface to use it in the subnet.

## Usage

```hcl
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
```

## Inputs

This module requires the following inputs:

- **common_name:** Common name for cloud resources on project.
- **availability_zones:** Azure physical data centers where resources will be located on current location.
- **resource_group:** Name of the Azure resource group where resources will be deployed.
- **location:** Azure location where resources will be deployed (e.g., East US, West Europe).
- **tags:** Tags to apply to resources, such as Terraform metadata or organizational info.
- **team_authorized_ips:** List of authorized IP addresses for team access.  
- **vnet_ip_range:** CIDR block defining the IP range for the Virtual Network.  
- **allow_ssh_access:** Boolean flag to enable or disable inbound SSH access (port 22).  
- **allow_http_access:** Boolean flag to enable or disable inbound HTTP access (port 80).  
- **http_public_access:** Boolean flag to allow public HTTP access. If `false`, restricts access to authorized IPs.  

## Outputs

This module exports the following outputs:

- **network_interface_ids:** The list of created network interface IDs

## Resources Created  

- **Virtual Network (VNet):** A virtual network to provide networking for Azure resources.  
- **Subnet:** A subnet within the VNet for resource allocation.  
- **Network Security Group (NSG):** A security group with customizable ingress and egress rules.  
- **Security Rules:** Configurable security rules to allow or restrict SSH and HTTP access.  
- **Public IP:** A dynamically allocated public IP address for external connectivity.  
- **Network Interface (NIC):** A network interface to connect resources to the subnet and public IP.  
