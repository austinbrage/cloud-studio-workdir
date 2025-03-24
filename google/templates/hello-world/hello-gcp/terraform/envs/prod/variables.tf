variable "google_project" {
  description = "Google Cloud project ID."
  type        = string
  default     = null
}

variable "google_region" {
  description = "Google Cloud region."
  type        = string
  default     = "us-central1"
}

variable "google_zones" {
  description = "Google physical data centers where resources will be located on current region."
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b", "us-central1-c", "us-central1-f"]
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

