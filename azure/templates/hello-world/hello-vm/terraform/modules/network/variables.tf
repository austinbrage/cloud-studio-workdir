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

variable "team_authorized_ips" {
  description = "List of IP addresses authorized for team members to access resources."
  type        = list(string)
  default     = []
}

variable "vnet_ip_range" {
  description = "The IP address range for the Virtual Network in CIDR notation."
  type        = string
  default     = "10.0.0.0/16"
}

variable "allow_ssh_access" {
  description = "Enable or disable inbound SSH access (port 22)."
  type        = bool
  default     = true
}

variable "allow_http_access" {
  description = "Enable or disable inbound HTTP access (port 80)."
  type        = bool
  default     = true
}

variable "http_public_access" {
  description = "Enable or disable public HTTP access. If false, restrict to IPs allowed for SSH."
  type        = bool
  default     = true
}