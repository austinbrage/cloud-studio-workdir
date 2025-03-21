variable "google_project" {
  description = "Google Cloud project ID."
  type        = string
  default     = null
}

variable "google_region" {
  description = "Google Cloud region."
  type        = string
  default     = "us-central1"
}

variable "google_zones" {
  description = "Google physical data centers where resources will be located on current region."
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b", "us-central1-c", "us-central1-f"]
}

variable "project_name" {
  description = "Name of the cloud project."
  type        = string
  default     = null
}

variable "team" {
  description = "Company team responsible for the cloud project."
  type        = string
  default     = null
}

variable "owner" {
  description = "Professional in charge of the cloud project."
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment of the cloud project (e.g; dev, prod, stage)."
  type        = string
  default     = null

  validation {
    condition     = contains(["dev", "prod", "stage"], var.environment)
    error_message = "The environment must be one of the following: 'dev', 'prod', 'stage'."
  }
}



/* Specific project VARIABLES */

variable "machine_type" {
  description = "The type of virtual machine to create."
  type        = string
  default     = null
}

variable "public_key_path" {
  description = "The public key path on current machine"
  type        = string
  default     = null
}

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

