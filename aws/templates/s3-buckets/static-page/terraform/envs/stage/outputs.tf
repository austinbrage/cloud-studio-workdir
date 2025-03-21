output "s3_bucket_name" {
  description = "Name of the S3 bucket."
  value       = module.s3.bucket_name
}

output "route53_name_servers" {
  description = "Name servers for the Route 53 Hosted Zone."
  value       = module.route53.route53_name_servers
}

output "cname_records" {
  description = "CNAME records required for domain validation in ACM"
  value = module.route53.cname_records
}

output "cloudfront_domain_name" {
  description = "The domain name of the cloudfront distribution."
  value       = module.cloudfront.domain_name
}
