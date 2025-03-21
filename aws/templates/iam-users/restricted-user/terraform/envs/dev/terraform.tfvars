# To view available regions and zones in AWS, visit:
# https://www.aws-services.info/regions.html

aws_region = "us-east-1"

project_name = "restricted-user"
environment  = "stage"

team  = "devops"
owner = "agustinbrage19@gmail.com"



/* Specific project DEFINITIONS */

user_name = "my_name"

policy_statements = [
  {
    effect    = "Allow"
    actions   = ["s3:ListBucket", "s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::my-specific-bucket", "arn:aws:s3:::my-specific-bucket/*"]
  },
  {
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances", "ec2:StartInstances", "ec2:StopInstances"]
    resources = ["*"]
  }
]