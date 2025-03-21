# Google Compute Instance Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)

This Terraform module creates a Google Compute Engine instance with Ubuntu 22.04 LTS as the boot image.

## Features

- Creates a Google Compute Engine VM instance with a custom name
- Configures a boot disk with the latest Ubuntu 22.04 LTS image
- Configures the network interface with a specified subnet and access config
- Supports SSH key authentication for login

## Usage

```hcl
module "vm" {
  source = "../../modules/vm"

  common_name = local.common_name
  zones       = var.google_zones

  public_key_path = var.public_key_path
  machine_type    = var.machine_type
  subnet_name     = module.network.subnet_name

  tags = local.global_tags
}
```

## Inputs

This module requires the following inputs:

- **common_name:** Common name for cloud resources on project.
- **zones:** Google physical data centers where resources will be located on current region.
- **tags:** Tags to apply to resources, such as Terraform metadata or organizational info.
- **subnet_name:** Name of the subnetwork created.
- **public_key_path:** The public key path on current machine.
- **machine_type:** The type of virtual machine to create.

## Outputs

This module exports the following outputs:

- **username:** Username of the CE instance.
- **public_ip:** Public IP of the deployed VM.
