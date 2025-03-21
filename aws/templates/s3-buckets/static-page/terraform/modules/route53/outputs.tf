output "certificate_arn" {
  description = "Amazon Resource Name of the SSL/TLS certificate."
  value = aws_acm_certificate_validation.main.certificate_arn
}

output "route53_name_servers" {
  description = "Name servers for the Route 53 Hosted Zone."
  value       = aws_route53_zone.main.name_servers
}

output "cname_records" {
  description = "CNAME records required for domain validation in ACM."
  value = aws_acm_certificate.main.domain_validation_options
}