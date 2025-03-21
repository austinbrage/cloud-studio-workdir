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
  description = "Name for the new admin user on IAM."
  type        = string
  default     = null

  validation {
    condition     = length(var.user_name) > 0
    error_message = "User name must not be empty."
  }
}

variable "billing_threshold" {
  description = "The billing threshold in USD to trigger the alarm (e.g., 5 for $5)."
  type        = number
}

variable "billing_period" {
  description = "The period in hours for the CloudWatch metric evaluation (e.g., 6 for 6 hours)."
  type        = number
}

variable "currency" {
  description = "The currency for the billing metric (e.g., 'USD')."
  type        = string
  default     = "USD"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the threshold. Typically set to 1 for simplicity."
  type        = number
  default     = 1
}