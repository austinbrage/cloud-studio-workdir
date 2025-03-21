variable "common_name" {
  description = "Common name for cloud resources on project."
  type        = string
  default     = null
}



/* Specific module VARIABLES */

variable "website_path" {
  description = "Absolute path to the website directory containing the files to upload."
  type        = string
}