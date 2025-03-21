# Deploy Compute Engine with Full Network Setup

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

This Terraform project sets up a complete Google Cloud network infrastructure, including a virtual network, subnet and network firewalls. Provisioning a Linux VM instance within the subnet, accessible via the internet and SSH.

## To be considered

This Terraform script is designed to be only allow the the **IP addresses** of the team members to connect to the VM through SSH. So in order to run the ansible playbook on the deployed VM, you have to add **your own public IP** to the **team_authorized_ips** variable on the .tfvars.

- You can use this site to get your public IP address: https://www.whatismyip.com 

## Key Features

- **VPC Network:** A VPC network with global routing mode to securely connect resources across regions.
- **Subnet:** A subnet created within the VPC for isolating resources with a defined IP range.
- **Firewall Rules:** Firewall rules for controlling inbound and outbound traffic, including SSH, HTTP, HTTPS access.
- **Compute Instances:** Google Compute Engine VM instances, including Ubuntu 22.04 LTS images, with customizable machine types and SSH key-based authentication.

## Ansible Configuration

Additional Ansible configuration to run an Nginx server for a SPA webpage.

  - **Environment Setup**: 
    - Installs Node.js and Nginx on the target server.
    - Clones a public GitHub repository containing the project code.
  - **Project Preparation**:
    - Runs `npm install` to install project dependencies.
    - Executes `npm build` to prepare the production-ready build.
  - **Nginx Deployment**:
    - Configures Nginx to serve the built project.
    - Ensures the application is running and accessible via the web server.

*Change the app_repo_url variable on the ansible playbook and use your own repo*
  
