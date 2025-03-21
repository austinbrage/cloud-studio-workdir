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
