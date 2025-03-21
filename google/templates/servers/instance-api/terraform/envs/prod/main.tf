terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  region  = var.google_region
  project = var.google_project
}

locals {
  common_name = "${var.project_name}-${var.environment}"

  global_tags = {
    managed_by  = "terraform"
    team        = var.team
    owner       = var.owner
    project     = var.project_name
    environment = var.environment
  }
}

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

module "vm" {
  source = "../../modules/vm"

  common_name = local.common_name
  zones       = var.google_zones

  public_key_path = var.public_key_path
  machine_type    = var.machine_type
  subnet_name     = module.network.subnet_name

  tags = local.global_tags
}
