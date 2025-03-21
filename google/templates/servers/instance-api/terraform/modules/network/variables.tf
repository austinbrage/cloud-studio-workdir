variable "region" {
  description = "Google Cloud region."
  type        = string
  default     = "us-central1"
}

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

variable "team_authorized_ips" {
  description = "List of IP addresses authorized for team members to access resources."
  type        = list(string)
  default     = []
}

variable "subnet_ip_range" {
  description = "The IP address range for the Virtual Subnetwork in CIDR notation."
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
