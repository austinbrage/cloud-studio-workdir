# AZURE VM Instance Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)

This Terraform module creates an Azure Linux Virtual Machine with configurable options such as the instance size, admin username, and SSH key. It also allows you to specify additional details such as the resource group and network interface.

## Features

- Deploy Azure Linux Virtual Machines with customizable instance size and resource configurations.  
- Use an existing SSH key from your file system for secure access.   
- Associate the VM with a specified resource group and network interface.

## Usage

```hcl
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
```

## Inputs

This module requires the following inputs:

- **common_name:** Common name for cloud resources on project.
- **availability_zones:** Azure physical data centers where resources will be located on current location.
- **resource_group:** Name of the Azure resource group where resources will be deployed.
- **location:** Azure location where resources will be deployed (e.g., East US, West Europe).
- **tags:** Tags to apply to resources, such as Terraform metadata or organizational info.
- **instance_type:** The VM size, defining CPU and memory resources.
- **username:** Username used for the ssh connection.
- **public_key_path:** Path in local file system for the public ssh key.
- **network_interface_ids:** List of network interface IDs (NICs) to associate with the module.

## Outputs

This module exports the following outputs:
 
- **public_ip:** The public IP address of the Linux VM from the network interface. 
