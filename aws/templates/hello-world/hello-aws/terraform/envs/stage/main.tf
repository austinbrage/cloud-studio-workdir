terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # Billing metric data is stored in the US East (N. Virginia) Region.
  region = "us-east-1"

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
  billing_period_in_seconds = var.billing_period * 3600
}


# 1. Create IAM user
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


# 2. Create Billing Alarm
resource "aws_sns_topic" "billing_alerts" {
  name = "billing-alerts-topic"
}

resource "aws_sns_topic_subscription" "billing_email" {
  topic_arn = aws_sns_topic.billing_alerts.arn
  protocol  = "email"
  endpoint  = var.owner
}

resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "BillingAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = local.billing_period_in_seconds
  statistic           = "Maximum"
  threshold           = var.billing_threshold
  alarm_description   = "Triggers when the estimated charges exceed the specified threshold."
  alarm_actions       = [aws_sns_topic.billing_alerts.arn]

  dimensions = {
    Currency = var.currency
  }
}