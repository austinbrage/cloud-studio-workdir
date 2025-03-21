locals {
  bucket_name = "${var.common_name}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "aws_s3_bucket" "main" {
  bucket = local.bucket_name
}

resource "aws_s3_object" "files" {
  for_each = fileset("${var.website_path}/", "**")
  source   = "${var.website_path}/${each.value}"

  bucket = aws_s3_bucket.main.bucket
  key    = each.value

  # Assign corresponding MIME type
  content_type = lookup({
    ".html" = "text/html",
    ".css"  = "text/css",
    ".js"   = "application/javascript",
    ".png"  = "image/png",
    ".jpg"  = "image/jpeg",
    ".svg"  = "image/svg+xml"
  }, regex("\\.[a-zA-Z0-9]+$", each.value), "binary/octet-stream")
}