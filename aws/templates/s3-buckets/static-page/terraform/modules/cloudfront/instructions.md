# Aws Cloudfront Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Amazon web services](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

This Terraform module creates a CloudFront distribution to securely serve content from a private S3 bucket.

## Features

- Configures a CloudFront Origin Access Control (OAC) to enable secure access to the S3 bucket using AWS Signature Version 4.
- Sets up a CloudFront distribution with HTTPS support, redirecting all HTTP traffic to HTTPS for enhanced security.
- Allows only specific HTTP methods (`GET` and `HEAD`) for caching and forwarding, ensuring efficient content delivery.
- Restricts access to the S3 bucket so that it can only be accessed through the CloudFront distribution, enhancing security.

## Usage

```hcl
module "cloudfront" {
  source = "../../modules/cloudfront"

  s3_bucket_id          = module.s3.bucket_id
  s3_bucket_arn         = module.s3.bucket_arn
  s3_bucket_name        = module.s3.bucket_name
  s3_bucket_domain_name = module.s3.bucket_domain_name
  certificate_arn       = module.route53.certificate_arn
}
```

## Inputs

This module requires the following inputs:

- **s3_bucket_id:** ID of the S3 bucket.
- **s3_bucket_arn:** Amazon Resource Name of the S3 bucket.
- **s3_bucket_name:** Name of the S3 bucket.
- **s3_bucket_domain_name:** Domain name of the S3 bucket.
- **certificate_arn:** Amazon Resource Name of the SSL/TLS certificate.

## Outputs

This module exports the following outputs:

- **domain_name:** The domain name of the CloudFront distribution.
- **hosted_zone_id:** The hosted zone ID of the CloudFront distribution.