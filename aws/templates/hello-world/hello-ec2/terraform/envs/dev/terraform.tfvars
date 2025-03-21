aws_region = "us-east-1"

project_name = "hello-ec2"
environment  = "stage"

team  = "devops"
owner = "agustinbrage19@gmail.com"

create_key_pair = true
key_name        = "dev"
public_key_path = "D:/my-projects/04-cloud-studio/workdir/prod/aws/keys/dev.key.pub"

vpc_cidr_block   = "10.2.0.0/16"
allow_ssh        = true
allow_http       = true
allow_https      = true
allow_all_egress = true

security_group_ingress = []
security_group_egress  = []

# ami_id = "ami-0440d3b780d96b29d"
ami_type       = "ubuntu"
instance_type  = "t2.micro"
instance_count = 1

# Put your team members IP addresses (including the /32 subnet mask)
team_authorized_ips = ["192.0.2.0/32"]
