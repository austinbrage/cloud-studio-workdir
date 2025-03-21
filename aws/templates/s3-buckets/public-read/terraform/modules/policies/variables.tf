variable "available_azs" {
  description = "List of availability zones to be used for resources within the selected AWS region."
  type        = list(string)
  default     = null
}

variable "common_name" {
  description = "Common name for cloud resources on project."
  type        = string
  default     = null
}



/* Specific module VARIABLES */

variable "bucket_id" {
  description = "The ID of the S3 bucket to attach the policies to."
  type        = string
}

variable "bucket_arn" {
  description = "The ARN of the S3 bucket to attach the policies to."
  type        = string
}