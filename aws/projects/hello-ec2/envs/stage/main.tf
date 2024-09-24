provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../../modules/network"

  environment  = var.environment
  project_name = var.project_name

  vpc_cidr_block    = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  create_key_pair   = var.create_key_pair
  key_name          = var.key_name
  public_key_path   = var.public_key_path

  allow_ssh        = var.allow_ssh
  allow_http       = var.allow_http
  allow_all_egress = var.allow_all_egress

  security_group_ingress = var.security_group_ingress
  security_group_egress  = var.security_group_egress

  tags = {
    Team  = var.team
    Owner = var.owner
  }
}

module "ec2" {
  source = "../../modules/ec2"

  environment  = var.environment
  project_name = var.project_name

  ami_type       = var.ami_type
  instance_type  = var.instance_type
  instance_count = var.instance_count
  user_data = templatefile("files/application_user_data.tmpl", {
    app_html = file("files/index.html")
  })

  key_name           = var.create_key_pair ? module.network.key_pair_name : var.key_name
  subnet_id          = module.network.subnet_id
  security_group_ids = [module.network.security_group_id]

  tags = {
    Team  = var.team
    Owner = var.owner
  }
}
