data "aws_iam_policy_document" "policy" {
  dynamic "statement" {
    for_each = var.policy_statements
    
    content {
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_policy" "policy" {
  name        = var.policy_name
  description = "Custom policy for specific access"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_group_policy_attachment" "policy" {
  group      = var.group_name
  policy_arn = aws_iam_policy.policy.arn
}