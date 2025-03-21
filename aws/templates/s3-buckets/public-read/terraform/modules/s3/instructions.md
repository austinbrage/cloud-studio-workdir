# AWS S3 Public Bucket Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Amazon Web Services](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

This Terraform module creates an S3 bucket with a unique name (random suffix) and configures it for public access. It allows uploading local files to the bucket and disables public access restrictions to enable public object retrieval.

## Features

- Creates an S3 bucket with a unique name based on a common prefix.
- Configures public access by disabling S3 public access blocks.
- Supports automatic file uploads from a local directory to the S3 bucket.
- Allows optional recursive upload of files from subdirectories.

## Usage

```hcl
module "s3" {
  source = "../../modules/s3"

  common_name     = local.common_name
  local_path      = var.local_path
  include_subdirs = var.include_subdirs
}
```

## Inputs

This module requires the following inputs:

- **common_name:** Common name for cloud resources on project.
- **local_path:** Path to the local directory containing the files to be uploaded.
- **enable_upload:** Whether uploading files to the S3 bucket from local path.
- **include_subdirs:** Whether all files from the subdirectories will be uploaded.

## Outputs

This module exports the following outputs:

- **bucket_id:** The name of the S3 bucket created.
- **bucket_arn:** The ARN of the S3 bucket created.
- **bucket_domain_name:** Outputs the S3 bucket's global domain name for public access.