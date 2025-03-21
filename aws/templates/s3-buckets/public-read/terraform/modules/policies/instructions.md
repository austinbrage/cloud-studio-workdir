# AWS IAM Policies Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Amazon web services](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

This Terraform module creates and attaches an S3 bucket policy that grants public read access to objects within the specified bucket. 

## Features

- Creates an S3 bucket policy that allows public read access (`s3:GetObject`).
- Attaches the generated policy to the specified S3 bucket.

## Usage

```hcl
module "policies" {
  source = "../../modules/policies"

  bucket_id  = module.s3.bucket_id
  bucket_arn = module.s3.bucket_arn
}
```

## Inputs

This module requires the following inputs:

- **bucket_id:** The ID of the S3 bucket to attach the policies to.
- **bucket_arn:** The ARN of the S3 bucket to attach the policies to.

## Outputs

This module exports no outputs.
