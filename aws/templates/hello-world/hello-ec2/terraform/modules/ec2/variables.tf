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

variable "ami_type" {
  type        = string
  description = "The type of Operating System Image (amazon_linux, ubuntu, etc.)"
  default     = "amazon_linux"

  validation {
    condition     = contains(keys(local.ami_filters), var.ami_type)
    error_message = "The ami_type must be one of the following: ${join(", ", keys(local.ami_filters))}."
  }
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = null

  validation {
    condition     = var.ami_id == null || can(regex("^ami-[a-zA-Z0-9]+$", var.ami_id))
    error_message = "If provided, the AMI ID must be a valid ID starting with \"ami-\"."
  }
}

variable "instance_type" {
  description = "Type of the instance"
  type        = string
  default     = null
}

variable "instance_count" {
  description = "Number of instances deployed"
  type        = number
  default     = 1
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "Security group IDs associated with the instance"
  type        = list(string)
  default     = []
}

variable "create_key_pair" {
  description = "Does a new key pair has to be created on aws"
  type        = bool
  default     = true
}

variable "public_key_path" {
  description = "The public key path on current machine"
  type        = string
  default     = null
}

variable "key_name" {
  description = "The name of the new kay pair to create on aws"
  type        = string
  default     = null

  validation {
    condition     = !(var.create_key_pair && (var.key_name == null || var.key_name == ""))
    error_message = "If create_key_pair is true, key_name must not be null or an empty string."
  }
}
