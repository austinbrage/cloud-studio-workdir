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

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = null
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

variable "create_before_destroy" {
  description = "Enable the creation of a new instance before destroying the existing one"
  type        = bool
  default     = false  
}

variable "user_data" {
  description = "Commands to execute on the machine when started"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to ec2 resource"
  type        = map(string)
  default     = {
    Team = "DevOps"
    Owner = "someaddress@gmail.com"
  }
}
