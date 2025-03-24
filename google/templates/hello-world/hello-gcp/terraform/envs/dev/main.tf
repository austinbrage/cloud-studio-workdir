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

locals {
  apis = {
    vms               = "compute.googleapis.com"
    iam               = "iam.googleapis.com"
    cloudresourcemgr  = "cloudresourcemanager.googleapis.com"
    servicenetworking = "servicenetworking.googleapis.com"
    sqldatabases      = "sqladmin.googleapis.com"
    dns               = "dns.googleapis.com"
    storage           = "storage.googleapis.com"
    logging           = "logging.googleapis.com"
    monitoring        = "monitoring.googleapis.com"
    pubsub            = "pubsub.googleapis.com"
    container         = "container.googleapis.com"
    artifactregistry  = "artifactregistry.googleapis.com"
    cloudfunctions    = "cloudfunctions.googleapis.com"
    cloudbuild        = "cloudbuild.googleapis.com"
    cloudrun          = "run.googleapis.com"
    secretmanager     = "secretmanager.googleapis.com"
    bigquery          = "bigquery.googleapis.com"
  }
}

resource "google_project_service" "required_apis" {
  for_each = local.apis
  service  = each.value
}