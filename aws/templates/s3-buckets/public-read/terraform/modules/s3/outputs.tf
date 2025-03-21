output "bucket_id" {
  description = "The name of the S3 bucket created."
  value       = aws_s3_bucket.public_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket created."
  value       = aws_s3_bucket.public_bucket.arn
}

output "bucket_domain_name" {
  description = "Outputs the S3 bucket's global domain name for public access."
  value       = aws_s3_bucket.public_bucket.bucket_domain_name
}