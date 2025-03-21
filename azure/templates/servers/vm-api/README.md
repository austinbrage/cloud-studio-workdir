# Deploy VM Instance to serve a Node API

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

This Terraform project sets up a complete AZURE network infrastructure, including a resource group, virtual network, subnet, network security group, public IP. and a network interface. Provisioning a Linux VM instance within the subnet, accessible via the internet and serving an API inside a Nginx server.

## To be considered

This Terraform script is designed to be only allow the the **IP addresses** of the team members to connect to the VM through SSH. So in order to run the ansible playbook on the deployed VM, you have to add **your own public IP** to the **team_authorized_ips** variable on the .tfvars.

- You can use this site to get your public IP address: https://www.whatismyip.com 

## Key Features

- **Resource Group**: A dedicated resource group to manage all related resources.
- **Virtual Network**: A virtual network with a defined address space.
- **Subnet**: A subnet within the virtual network for VM communication.
- **Network Security Group (NSG)**: Allows inbound traffic from a specified personal IP.
- **Public IP**: A dynamically allocated public IP for external access.
- **Linux Virtual Machines**: An Ubuntu 22.04 VM in the public subnet with a public IP address.

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
  