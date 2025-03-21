variable "common_name" {
  description = "Common name for cloud resources on project."
  type        = string
  default     = null
}



/* Specific module VARIABLES */

variable "s3_bucket_id" {
  description = "ID of the S3 bucket."
  type        = string
  default     = null
}

variable "s3_bucket_arn" {
  description = "Amazon Resource Name of the S3 bucket."
  type        = string
  default     = null
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket."
  type        = string
  default     = null
}

variable "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket."
  type        = string
  default     = null
}

variable "certificate_arn" {
  description = "Amazon Resource Name of the SSL/TLS certificate."
  type        = string
  default     = null
}