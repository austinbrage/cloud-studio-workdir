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

resource "aws_iam_user" "admin_user" {
  name = var.user_name

  tags = {
    Role = "Administrator"
  }
}

resource "aws_iam_group" "admin_group" {
  name = "AdminGroup"
}

resource "aws_iam_group_policy_attachment" "admin_group_policy_attachment" {
  group      = aws_iam_group.admin_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user_group_membership" "admin_user_membership" {
  user   = aws_iam_user.admin_user.name
  groups = [aws_iam_group.admin_group.name]
}

resource "aws_iam_user_login_profile" "admin_user_login_profile" {
  user = aws_iam_user.admin_user.name
}