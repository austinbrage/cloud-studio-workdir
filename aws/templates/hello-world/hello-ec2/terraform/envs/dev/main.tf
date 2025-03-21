terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Managed_by  = "Terraform"
      Team        = var.team
      Owner       = var.owner
      Project     = var.project_name
      Environment = var.environment
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az_names    = data.aws_availability_zones.available.names
  common_name = "${var.project_name}-${var.environment}"
}

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

