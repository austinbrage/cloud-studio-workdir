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

variable "local_path" {
  description = "Path to the local directory containing the files to be uploaded."
  type        = string
  default     = null
}

variable "enable_upload" {
  type        = bool
  description = "Whether uploading files to the S3 bucket from local path."
  default     = true
}

variable "include_subdirs" {
  description = "Whether all files from the subdirectories will be uploaded."
  type        = bool
  default     = false
}
