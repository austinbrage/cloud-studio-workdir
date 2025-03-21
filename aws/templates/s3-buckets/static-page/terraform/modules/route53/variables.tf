variable "common_name" {
  description = "Common name for cloud resources on project."
  type        = string
  default     = null
}



/* Specific module VARIABLES */

variable "root_domain" {
  description = "The root domain name for the hosted zone (e.g., awesome.com)."
  type        = string
  default     = null
}

variable "sub_domain" {
  description = "The sub domain name for the cloudfront registration (e.g., www)."
  type        = string
  default     = null
}

variable "cloudfront_domain_name" {
  description = "The domain name of the cloudfront distribution."
  type        = string
  default     = null
}

variable "cloudfront_hosted_zone_id" {
  description = "The hosted zone id of the cloudfront distribution."
  type        = string
  default     = null
}
