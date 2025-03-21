locals {
  bucket_name = "${var.common_name}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = local.bucket_name
}

# Disable public access blocks
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.public_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Init bucket with local files
resource "aws_s3_object" "files" {
  for_each = var.enable_upload ? {
    for file in fileset(var.local_path, var.include_subdirs ? "**/*" : "*") :
    file => file
  } : {}

  source = "${var.local_path}/${each.value}"
  bucket = aws_s3_bucket.public_bucket.id
  key    = each.value
}

