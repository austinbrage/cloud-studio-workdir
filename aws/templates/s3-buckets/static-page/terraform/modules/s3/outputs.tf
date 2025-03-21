output "bucket_id" {
  description = "ID of the S3 bucket."
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "Amazon Resource Name of the S3 bucket."
  value       = aws_s3_bucket.main.arn
}

output "bucket_name" {
  description = "Name of the S3 bucket."
  value       = local.bucket_name
}

output "bucket_domain_name" {
  description = "Domain name of the S3 bucket."
  value       = aws_s3_bucket.main.bucket_regional_domain_name
}