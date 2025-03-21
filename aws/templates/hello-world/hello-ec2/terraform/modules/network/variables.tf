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

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = null

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.vpc_cidr_block))
    error_message = "The cidr_block must be a valid CIDR block in the format x.x.x.x/y (e.g., 10.0.0.0/16)."
  }
}

variable "team_authorized_ips" {
  description = "List of IP addresses authorized for team members to access resources."
  type        = list(string)
  default     = []
}

variable "allow_ssh" {
  description = "Allow SSH (port 22)"
  type        = bool
  default     = true
}

variable "allow_http" {
  description = "Allow HTTP (port 80)"
  type        = bool
  default     = true
}

variable "allow_https" {
  description = "Allow HTTPS (port 443)"
  type        = bool
  default     = true
}

variable "allow_all_egress" {
  description = "Allow all egress traffic"
  type        = bool
  default     = true
}

variable "security_group_ingress" {
  description = "Ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "security_group_egress" {
  description = "Egress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
