aws_region = "us-east-2"

project_name = "hello-world"
environment = "prod"

team = "dev_ops"
owner = "myaddress@gmail.com"

vpc_cidr_block = "10.1.0.0/16"
subnet_cidr_block = "10.1.1.0/24"

create_key_pair = true
key_name = "prod-projects"
public_key_path = "C:/Users/Pc/.ssh/dev-projects.key.pub"

allow_ssh = true
allow_http = true
allow_all_egress = true

security_group_ingress = []
security_group_egress = []

# ami_id = "ami-0440d3b780d96b29d"
ami_type = "amazon_linux"
instance_type = "t2.micro"
instance_count = 1