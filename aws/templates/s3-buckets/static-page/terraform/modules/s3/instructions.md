# Aws S3 Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Amazon web services](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

This Terraform module creates a private S3 bucket and uploads files from the `website` folder to it.

## Features

- Creates a uniquely named private S3 bucket.
- Automatically uploads all files from the `website` folder to the bucket.
- Assigns appropriate MIME types to uploaded files based on their extensions (e.g., `.html`, `.css`, `.js`, etc.).
- Generates a unique bucket name using a random string suffix to avoid naming conflicts.

## Usage

```hcl
module "s3" {
  source = "../../modules/s3"

  common_name  = local.common_name
}
```

## Inputs

This module requires the following inputs:

- **common_name:** Common name for cloud resources on project.

## Outputs

This module exports the following outputs:

- **bucket_id:** ID of the S3 bucket.
- **bucket_arn:** Amazon Resource Name of the S3 bucket.
- **bucket_name:** Name of the S3 bucket.
- **bucket_domain_name:** Domain name of the S3 bucket.
