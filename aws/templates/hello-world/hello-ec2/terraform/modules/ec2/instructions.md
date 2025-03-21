# AWS EC2 Instance Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Amazon web services](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

This Terraform module creates an Amazon EC2 instance with configurable options such as the AMI, instance type, and key pair. It also allows you to specify additional details such as subnet and security groups.

## Features

- Deploy EC2 instances with customizable AMI, instance type, and count.  
- Optionally create a new AWS key pair or use an existing one for SSH access.  
- Choose from predefined OS images (e.g., Amazon Linux, Ubuntu) or provide a custom AMI ID.

## Usage

```hcl
module "ec2" {
  source = "../../modules/ec2"

  common_name   = local.common_name
  available_azs = local.az_names

  key_name        = var.key_name
  public_key_path = var.public_key_path
  create_key_pair = var.create_key_pair

  ami_type       = var.ami_type
  instance_type  = var.instance_type
  instance_count = var.instance_count
  
  subnet_id          = module.network.subnet_id
  security_group_ids = [module.network.security_group_id]
}
```

## Inputs

This module requires the following inputs:

- **common_name:** Common name for cloud resources on the project.
- **ami_type:** The type of Operating System Image (e.g., amazon_linux, ubuntu, etc.).
- **instance_type:** Type of the instance.
- **subnet_id:** The subnet ID to launch the instance in.
- **create_key_pair:** Does a new key pair have to be created on AWS?
- **public_key_path:** The public key path on the current machine (required if create_key_pair is true).
- **key_name:** The name of the new key pair to create on AWS (required if create_key_pair is true).

## Outputs

This module exports the following outputs:

- **instance_id:** The ID of the created EC2 instance.
- **private_ip:** The private IP address of the instance. 
- **public_ip:** The public IP address of the instance. 

## Supported Operating Systems

This module supports the following AMIs by default:

- **Amazon Linux 2:** Lightweight, optimized for AWS.
- **Ubuntu:** Popular open-source OS with long-term support.
- **Debian:** Stable and secure OS ideal for servers.

> You can override the **ami_id** to use any other AMI you prefer.