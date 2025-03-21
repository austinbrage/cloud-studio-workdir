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

locals {
  common_name = "${var.project_name}-${var.environment}"
}


module "s3" {
  source = "../../modules/s3"

  common_name     = local.common_name
  local_path      = var.local_path
  enable_upload   = var.enable_upload
  include_subdirs = var.include_subdirs
}

module "policies" {
  source = "../../modules/policies"

  bucket_id  = module.s3.bucket_id
  bucket_arn = module.s3.bucket_arn
}
