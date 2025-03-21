output "domain_name" {
  description = "The domain name of the cloudfront distribution."
  value       = aws_cloudfront_distribution.main.domain_name
}

output "hosted_zone_id" {
  description = "The hosted zone id of the cloudfront distribution."
  value       = aws_cloudfront_distribution.main.hosted_zone_id
}
