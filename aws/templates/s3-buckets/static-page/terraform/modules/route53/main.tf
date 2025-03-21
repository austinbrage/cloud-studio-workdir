# Copy the Name Servers of the created Hosted Zone given by the output and use to redirect it with a domain name of your own

resource "aws_route53_zone" "main" {
  name = var.root_domain
}

resource "aws_route53_record" "alias" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "${var.sub_domain}.${var.root_domain}"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}


# Create and validate SSL/TLS certificate for HTTPS requests
resource "aws_acm_certificate" "main" {
  domain_name       = var.root_domain
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.root_domain}" # All subdomains are included
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}
 