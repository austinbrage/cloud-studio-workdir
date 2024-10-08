provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../../modules/network"

  environment       = var.environment
  project_name      = var.project_name

  vpc_cidr_block    = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  create_key_pair   = true
  key_name          = var.key_name
  public_key_path   = var.public_key_path

  security_group_ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Team = var.team
    Owner = var.owner
  } 
}

module "ec2" {
  source  = "../../modules/ec2"

  environment         = var.environment
  project_name        = var.project_name

  ami_id              = var.ami_id
  instance_type       = var.instance_type
  instance_count      = var.instance_count
  user_data           = templatefile("files/application_user_data.tmpl", {
    app_html          = file("files/index.html") 
  }) 

  key_name            = var.create_key_pair ? module.network.key_pair_name : var.key_name
  subnet_id           = module.network.subnet_id
  security_group_ids  = [module.network.security_group_id]

  tags = {
    Team = var.team
    Owner = var.owner
  }  
}
