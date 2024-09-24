variable "project_name" {
  description = "Name of the cloud project"
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

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = null
  
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.vpc_cidr_block))
    error_message = "The cidr_block must be a valid CIDR block in the format x.x.x.x/y (e.g., 10.0.0.0/16)."
  }
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
  default     = null
  
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.subnet_cidr_block))
    error_message = "The cidr_block must be a valid CIDR block in the format x.x.x.x/y (e.g., 10.0.0.0/16)."
  }
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

variable "allow_all_egress" {
  description = "Allow all egress traffic"
  type        = bool
  default     = true
}

variable "security_group_ingress" {
  description = "Ingress rules for the security group"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default     = []
}

variable "security_group_egress" {
  description = "Egress rules for the security group"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default     = []
}

variable "create_key_pair" {
  description = "Does the a new key pair has to be created on aws"
  type        = bool
  default     = true
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
  default     = null
  
  validation {
    condition     = var.key_name == null || length(var.key_name) > 0
    error_message = "If provided, the key pair name must not be empty." 
  }
}

variable "public_key_path" {
  description = "The public key path on current machine"
  type        = string
  default     = null
}

variable "common_tags" {
  description  = "Map of common tags to apply to network resources, defined on the module by default value"
  type         = map(string)
  default      = {
     Terraform = "true"
  }
}

variable "tags" {
  description = "Tags to apply to all network resources, such as Terraform metadata or organizational information"
  type        = map(string)
  default     = {
    Team = "DevOps"
    Owner = "someaddress@gmail.com"
  }
  
  validation {
    condition     = contains(keys(var.tags), "Owner") && contains(keys(var.tags), "Team")
    error_message = "The 'tags' variable must include: \"Owner\" and \"Team\"."
  }
}
