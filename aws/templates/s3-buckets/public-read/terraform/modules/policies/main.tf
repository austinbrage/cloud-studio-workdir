data "aws_iam_policy_document" "public_read_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${var.bucket_arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.public_read_policy.json
}