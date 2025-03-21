# Important: Make sure to change the PASSWORD of the new user in the console after creating

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

resource "aws_iam_user" "specific_access_user" {
  name = var.user_name

  tags = {
    Role = "SpecificAccess"
  }
}

resource "aws_iam_group" "specific_access_group" {
  name = "specific-access-group"
}

resource "aws_iam_user_group_membership" "specific_access_membership" {
  user   = aws_iam_user.specific_access_user.name
  groups = [aws_iam_group.specific_access_group.name]
}

resource "aws_iam_user_login_profile" "specific_access_user_login_profile" {
  user = aws_iam_user.specific_access_user.name
}

module "policies" {
  source = "../../modules/policies"

  group_name        = aws_iam_group.specific_access_group.name
  policy_name       = "specific-access-policy"
  policy_statements = var.policy_statements
}
