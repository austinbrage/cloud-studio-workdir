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
      Environment = var.environment
      Project     = var.project_name
      Owner       = var.owner
      Team        = var.team
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

module "s3" {
  source = "../../modules/s3"

  common_name  = local.common_name
  website_path = "${path.root}/../../../website"
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  s3_bucket_id          = module.s3.bucket_id
  s3_bucket_arn         = module.s3.bucket_arn
  s3_bucket_name        = module.s3.bucket_name
  s3_bucket_domain_name = module.s3.bucket_domain_name
  certificate_arn       = module.route53.certificate_arn
}

module "route53" {
  source = "../../modules/route53"

  root_domain = var.root_domain
  sub_domain  = var.sub_domain
 
  cloudfront_domain_name    = module.cloudfront.domain_name
  cloudfront_hosted_zone_id = module.cloudfront.hosted_zone_id
}
