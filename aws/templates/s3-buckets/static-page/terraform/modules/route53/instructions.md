# Aws Route53 Terraform Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Amazon web services](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

This Terraform module creates a Route 53 Hosted Zone, configures an alias record for a subdomain pointing to a CloudFront distribution, and sets up an SSL/TLS certificate for secure HTTPS requests.

## To be considered

Before using this module, **the domain** must be registered in Route 53 for the module to work properly. This is required because the module creates a hosted zone and uses Route 53 records to validate the ACM certificate.

- The **ACM certificate** is validated using DNS records created in Route 53. Without this validation, the certificate cannot be used.

### Using a third-party DNS provider

If your domain is registered with a **third-party provider** (GoDaddy, Namecheap, Cloudflare, etc.), you must manually add the required CNAME records for ACM validation. You can retrieve these records from the module output.

- Copy the **CNAME records** provided in the output and add them to your DNS provider's configuration. The ACM certificate will only be validated once these records are correctly set up.

## Features

- Creates a Route 53 Hosted Zone for the specified root domain.
- Configures an alias record to redirect a subdomain to a CloudFront distribution using the provided domain name and hosted zone ID.
- Generates and validates an SSL/TLS certificate for the root domain and all its subdomains to enable secure HTTPS connections.
- Automates DNS validation by creating the necessary Route 53 records for the SSL/TLS certificate.
- Ensures seamless updates with a lifecycle rule to create new resources before destroying old ones during updates.

## Usage

```hcl
module "route53" {
  source = "../../modules/route53"

  root_domain = var.root_domain
  sub_domain  = var.sub_domain

  cloudfront_domain_name    = module.cloudfront.domain_name
  cloudfront_hosted_zone_id = module.cloudfront.hosted_zone_id
}
```
## Inputs

This module requires the following inputs:

- **root_domain:** The root domain name for the hosted zone (e.g., awesome.com).
- **sub_domain:** The subdomain name for the CloudFront registration (e.g., www).
- **cloudfront_domain_name:** The domain name of the CloudFront distribution.
- **cloudfront_hosted_zone_id:** The hosted zone ID of the CloudFront distribution.

## Outputs

This module exports the following outputs:

- **certificate_arn:** Amazon Resource Name of the SSL/TLS certificate.
- **route53_name_servers:** Name servers for the Route 53 Hosted Zone.
- **cname_records:** CNAME records required for domain validation in ACM.
