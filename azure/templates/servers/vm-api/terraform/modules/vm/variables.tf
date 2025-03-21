variable "location" {
  description = "Azure location where resources will be deployed (e.g., East US, West Europe)."
  type        = string
  default     = "East US"
}

variable "availability_zones" {
  description = "Azure physical data centers where resources will be located on current location."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "resource_group" {
  description = "Name of the Azure resource group where resources will be deployed."
  type        = string
  default     = null
}

variable "common_name" {
  description = "Common name for cloud resources on project."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to this resource, such as Terraform metadata or organizational information."
  type        = map(string)
  default = {
    Team  = "DevOps"
    Owner = "someaddress@gmail.com"
  }

  validation {
    condition     = contains(keys(var.tags), "Owner") && contains(keys(var.tags), "Team")
    error_message = "The 'tags' variable must include 'Owner' and 'Team' keys."
  }
}



/* Specific module VARIABLES */

variable "instance_size" {
  description = "The VM size, defining CPU and memory resources."
  type        = string
  default     = null
}

variable "username" {
  description = "Username used for the ssh connection."
  type        = string
  default     = null
}

variable "public_key_path" {
  description = "Path in local file system for the public ssh key."
  type        = string
  default     = null
}

variable "network_interface_ids" {
  description = "List of network interface IDs (NICs) to associate with the module."
  type        = list(string)
  default     = []
}
