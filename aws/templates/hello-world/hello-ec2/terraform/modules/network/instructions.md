# AWS Network Terraform module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) ![Amazon web services](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

This Terraform module creates essential networking resources in AWS, including a VPC, subnet, security group, internet gateway, route table, and optionally, a key pair for SSH access.

## Features

- Creates a VPC with customizable CIDR block.
- Defines a subnet within the VPC.
- Configures a security group with dynamic ingress and egress rules.
- Sets up an internet gateway and a route table for internet access.

## Usage

```hcl
module "network" {
  source = "../../modules/network"

  common_name   = local.common_name
  available_azs = local.az_names
  
  vpc_cidr_block      = var.vpc_cidr_block
  team_authorized_ips = var.team_authorized_ips
  
  allow_ssh        = var.allow_ssh
  allow_http       = var.allow_http
  allow_https      = var.allow_https
  allow_all_egress = var.allow_all_egress

  security_group_ingress = var.security_group_ingress
  security_group_egress  = var.security_group_egress
}
```

## Inputs

This module requires the following inputs:

- **common_name:** Common name for cloud resources on the project.
- **team_authorized_ips:** List of IP addresses authorized for team members to access resources.
- **vpc_cidr_block:** CIDR block for the VPC (e.g., `10.0.0.0/16`).
- **allow_ssh:** Whether to allow SSH (port 22). Default is `true`.
- **allow_http:** Whether to allow HTTP (port 80). Default is `true`.
- **allow_https:** Whether to allow HTTPS (port 443). Default is `true`.
- **allow_all_egress:** Whether to allow all outbound traffic. Default is `true`.
- **security_group_ingress:** Custom ingress rules for the security group. Default is an empty list (`[]`).
- **security_group_egress:** Custom egress rules for the security group. Default is an empty list (`[]`).


## Outputs

This module exports the following outputs:

- **vpc_id:** The ID of the created VPC.
- **subnet_id:** The ID of the created subnet.
- **security_group_id:** The ID of the created security group.
- **internet_gateway_id:** The ID of the created internet gateway.
- **route_table_id:** The ID of the created route table.

## Resources Created

- **VPC**: A Virtual Private Cloud for your networking needs.
- **Subnet**: A subnet for your instances to reside within the VPC.
- **Security Group**: A security group with customizable ingress and egress rules.
- **Internet Gateway**: A gateway to provide internet access.
- **Route Table**: A table that routes traffic from the subnet to the internet.
