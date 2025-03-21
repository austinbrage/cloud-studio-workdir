variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the cloud project."
  type        = string
  default     = null
}

variable "team" {
  description = "Company team responsible for the cloud project."
  type        = string
  default     = null
}

variable "owner" {
  description = "Professional in charge of the cloud project."
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment of the cloud project (e.g; dev, prod, stage)."
  type        = string
  default     = null

  validation {
    condition     = contains(["dev", "prod", "stage"], var.environment)
    error_message = "The environment must be one of the following: 'dev', 'prod', 'stage'."
  }
}



/* Specific project VARIABLES */

variable "user_name" {
  description = "Name for the new specific access user on IAM."
  type        = string
  default     = null
}

variable "policy_statements" {
  description = "List of policy statements for the custom policy"
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
}