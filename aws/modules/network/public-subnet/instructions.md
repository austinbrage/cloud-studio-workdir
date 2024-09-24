# AWS Network Terraform modules

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) ![Amazon web services](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

Terraform module which creates:

  1. VPC
  2. Subnet
  3. Security group
  4. Internet gateway
  5. Route table
  6. Route table association
  7. Key pair

  In order to make a public subnet with internet access

## Usage

#### main.tf

```hcl
module "network" {
  source = "../../modules/network"

  environment       = var.environment
  project_name      = var.project_name

  vpc_cidr_block    = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  create_key_pair   = var.create_key_pair
  key_name          = var.key_name
  public_key_path   = var.public_key_path

  security_group_ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Team = var.team
    Owner = var.owner
  } 
}
```

#### variables.tf

```hcl
variable "project_name" {
  description = "Name of the cloud project"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment of the cloud project (e.g; dev, prod, stage)"
  type        = string
  default     = null
}

variable "team" {
  description = "Company team responsible for the cloud project"
  type        = string
  default     = null
}

variable "owner" {
  description = "Professional in charge of the cloud project"
  type        = string
  default     = null
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = null
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
  default     = null
}

variable "create_key_pair" {
  description = "Does the a new key pair has to be created on aws"
  type        = bool
  default     = true
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
  default     = null
}

variable "public_key_path" {
  description = "The public key path on current machine"
  type        = string
  default     = null
}
```

#### terraform.tfvars

```hcl
project_name = "hello-world"
environment = "dev"

team = "dev_ops"
owner = "myaddress@gmail.com"

vpc_cidr_block = "10.0.0.0/16"
subnet_cidr_block = "10.0.1.0/24"

create_key_pair = true
key_name = "dev-projects"
public_key_path = "C:/Users/Pc/.ssh/dev-projects.key.pub"
```