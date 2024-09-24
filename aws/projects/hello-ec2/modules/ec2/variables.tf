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

variable "ami_type" {
  type        = string
  description = "The type of Operating System Image (amazon_linux, ubuntu, etc.)"
  default     = "amazon_linux"
  
  validation {
    condition     = contains(["amazon_linux", "ubuntu", "debian"], var.ami_type)
    error_message = "The ami_type must be one of the following: \"amazon_linux\", \"ubuntu\", \"debian\"."
  }
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = null
  
  validation {
    condition = var.ami_id == null || can(regex("^ami-[a-zA-Z0-9]+$", var.ami_id))
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

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = null
  
  validation {
    condition     = var.key_name == null || length(var.key_name) > 0
    error_message = "If provided, the key pair name must not be empty." 
  }
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

variable "user_data" {
  description = "Commands to execute on the machine when started"
  type        = string
  default     = null
  
  validation {
    condition     = var.user_data == null || length(var.user_data) > 0
    error_message = "If provided, user data must not be empty."
  }
}

variable "common_tags" {
  description  = "Map of common tags to apply to ec2 resources, defined on the module by default value"
  type         = map(string)
  default      = {
     Terraform = "true"
  }
}

variable "tags" {
  description = "Tags to apply to all ec2 resources, such as Terraform metadata or organizational information"
  type        = map(string)
  default     = {
    Team = "DevOps"
    Owner = "someaddress@gmail.com"
  }
  
  validation {
    condition     = contains(keys(var.tags), "Owner") && contains(keys(var.tags), "Team")
    error_message = "The 'tags' variable must include \"Owner\" and \"Team\"."
  }
}