# Google Network Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)

This Terraform module provisions a Google Cloud VPC network with a custom subnet and configurable firewall rules for SHH, HTTP ingress and internet egress.

## Features

- Creates a VPC network with global routing
- Deploys a custom subnet with user-defined CIDR range
- Configurable ingress firewall rules for SSH and HTTP/HTTPS
- Egress rule allowing all outbound traffic

## Usage

```hcl
module "network" {
  source = "../../modules/network"

  common_name = local.common_name
  region      = var.google_region
  zones       = var.google_zones

  subnet_ip_range    = var.subnet_ip_range
  allow_ssh_access   = var.allow_ssh_access
  allow_http_access  = var.allow_http_access
  http_public_access = var.http_public_access

  tags = local.global_tags
}
```

## Inputs

This module requires the following inputs:

- **common_name:** Common name for cloud resources on project.
- **region**: Google Cloud region.
- **zones:** Google physical data centers where resources will be located on current region.
- **tags:** Tags to apply to resources, such as Terraform metadata or organizational info.
- **team_authorized_ips:** List of authorized IP addresses for team access.  
- **vnet_ip_range:** CIDR block defining the IP range for the Virtual Network.  
- **allow_ssh_access:** Boolean flag to enable or disable inbound SSH access (port 22).  
- **allow_http_access:** Boolean flag to enable or disable inbound HTTP access (port 80).  
- **http_public_access:** Boolean flag to allow public HTTP access. If `false`, restricts access to authorized IPs. 

## Outputs

This module exports the following outputs:

- **subnet_name:** Name of the subnetwork created.

## Resources Created

- **google_compute_network:** VPC network with global routing mode.
- **google_compute_subnetwork:** Custom subnet with specified IP range.
- **google_compute_firewall.allow-ssh:** Optional firewall rule allowing SSH ingress.
- **google_compute_firewall.allow-http:** Optional firewall rule allowing HTTP/HTTPS ingress.
- **google_compute_firewall.allow-egress:** Firewall rule allowing all egress traffic.
