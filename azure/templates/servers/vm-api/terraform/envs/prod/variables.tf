variable "azure_location" {
  description = "Azure location where resources will be deployed (e.g., East US, West Europe)."
  type        = string
  default     = "East US"
}

variable "availability_zones" {
  description = "Azure physical data centers where resources will be located on current location."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "project_name" {
  description = "Name of the cloud project"
  type        = string
  default     = null
}

variable "team" {
  description = "Company team responsible for the cloud project"
  type        = string
  default     = null
}

variable "owner" {
  description = "Professional in charge of the cloud project"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment of the cloud project (e.g; dev, prod, stage)"
  type        = string
  default     = null

  validation {
    condition     = contains(["dev", "prod", "stage"], var.environment)
    error_message = "The environment must be one of the following: \"dev\", \"prod\", \"stage\"."
  }
}



/* Specific project VARIABLES */

variable "instance_size" {
  description = "The VM size, defining CPU and memory resources."
  type        = string
  default     = null
}

variable "username" {
  description = "Username used for the ssh connection"
  type        = string
  default     = null
}

variable "public_key_path" {
  description = "Path in local file system for the public ssh key"
  type        = string
  default     = null
}

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
