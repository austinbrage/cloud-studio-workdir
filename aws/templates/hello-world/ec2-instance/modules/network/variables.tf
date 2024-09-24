variable "project_name" {
  description = "Name of the cloud project"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment of the cloud project (e.g; dev, prod, stage)"
  type        = string
  default     = null
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = null
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
  default     = null
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
}

variable "public_key_path" {
  description = "The public key path on current machine"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to all network resources"
  type        = map(string)
  default     = {
    Team = "DevOps"
    Owner = "someaddress@gmail.com"
  }
}
