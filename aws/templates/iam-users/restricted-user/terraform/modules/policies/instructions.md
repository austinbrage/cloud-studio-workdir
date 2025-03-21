# AWS IAM Policies Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Amazon web services](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

This module creates and attaches a customIAM policy to a specified IAM user. The policy is defined dynamically using the **policy_statements** variable, which allows you to specify multiple statements with different effects, actions, and resources.

## Features

- Define custom IAM policy statements with flexible effects, actions, and resources.
- Generates an IAM policy using a dynamically constructed policy document.
- Attaches the custom policy to the IAM group, which the specified user belongs to.

## Usage

```hcl
module "custom_policy" {
  source = "../../modules/policies"

  group_name        = aws_iam_group.specific_access_group.name
  policy_name       = "specific-access-policy"
  policy_statements = var.policy_statements
}
```

## Inputs

This module requires the following inputs:

- **group_name:** Name of the IAM group to attach the policy to.
- **policy_name:** Name of the IAM policy.
- **policy_statements:** List of policy statements.

## Outputs

This module exports no outputs.
