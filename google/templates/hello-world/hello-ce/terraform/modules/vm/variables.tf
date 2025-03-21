variable "zones" {
  description = "Google physical data centers where resources will be located on current region."
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b", "us-central1-c", "us-central1-f"]
}

variable "common_name" {
  description = "Common name for cloud resources on project."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources, such as Terraform metadata or organizational info."
  type        = map(string)
  default = {
    Team  = "devops"
    Owner = "youraddress@gmail.com"
  }
}



/* Specific module VARIABLES */

variable "subnet_name" {
  description = "Name of the subnetwork created."
  type        = string
  default     = null
}

variable "public_key_path" {
  description = "The public key path on current machine"
  type        = string
  default     = null
}

variable "machine_type" {
  description = "The type of virtual machine to create."
  type        = string
  default     = null
}
