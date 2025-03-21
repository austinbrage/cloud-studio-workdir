# Deploy EC2 Instance to serve a Node API

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

This Terraform project sets up a complete AWS network infrastructure, including a VPC, subnet, security groups and internet gateway. Provisioning an EC2 instance within the subnet, accessible via the internet and serving an API inside a Nginx server.

## To be considered

This Terraform script is designed to be only allow the the **IP addresses** of the team members to connect to the EC2 through SSH. So in order to run the ansible playbook on the deployed EC2, you have to add **your own public IP** to the **team_authorized_ips** variable on the .tfvars.

- The IPs in this variable must be written in CIDR notation and include the /32 subnet mask.
- You can use this site to get your public IP address: https://www.whatismyip.com 

## Key Features

- **VPC Creation**: A dedicated Virtual Private Cloud (VPC) with a custom CIDR block.
- **Subnet Provisioning**: A public subnet within the VPC for hosting the EC2 instance.
- **Security Group Configuration**: A security group allowing SSH and HTTP access from anywhere.
- **Internet Gateway**: An internet gateway attached to the VPC to enable internet access on subnet.
- **EC2 Instance Deployment**: An EC2 instance launched in the public subnet with a public IP address.

## Ansible Configuration

The Ansible playbook runs an Nginx server for an API.

  - **Environment Setup**: 
    - Installs Node.js and Nginx on the target server.
    - Clones a public GitHub repository containing the project code.
  - **Project Preparation**:
    - Runs `pnpm install` to install project dependencies.
    - Executes `pm2 start` to serve the API inside the instance.
  - **Nginx Deployment**:
    - Configures Nginx to serve the built project.
    - Ensures the application is running and accessible via the web server.

*Change the app_repo_url variable on the ansible playbook and use your own repo*
  