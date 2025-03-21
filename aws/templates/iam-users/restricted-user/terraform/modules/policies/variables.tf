variable "group_name" {
  description = "Name of the IAM group to attach the policy to."
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM policy."
  type        = string
}

variable "policy_statements" {
  description = "List of policy statements to include in the policy document."
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
}