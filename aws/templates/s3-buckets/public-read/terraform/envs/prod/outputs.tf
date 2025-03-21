output "bucket_id" {
  description = "The name of the S3 bucket created."
  value       = module.s3.bucket_id
}

output "bucket_domain_name" {
  description = "Outputs the S3 bucket's global domain name for public access."
  value       = "https://${module.s3.bucket_domain_name}"
}
