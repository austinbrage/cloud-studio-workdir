# Deploy EC2 Instance with Full Network Setup

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

This Terraform project sets up a complete AWS network infrastructure, including a VPC, subnet, security groups and internet gateway. Provisioning a Linux VM instance within the subnet, accessible via the internet and SSH.

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
  
## CI/CD Workflow

For pipelines to keep the content of the EC2 automatically updated, a Github Action can be used. Through the values of **EC2_SSH_PRIVATE_KEY** and **EC2_HOST** (or public ip) stored in Github Secrets to connect to that instance.

### IMPORTANT

Since this project only allow the IP addresses of the team members to connect through SSH, this Github Workflow will fail unless...

1. Change the value of **cidr_blocks** to ["*"] on the ssh_rule local inside the network module to allow anyone to connect to the VM.
2. Reconfigure this worflow and install the Github runner on the VM to use it as a **self-hosted runner**.

```yaml
name: Deployment on EC2 through SSH

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      APP_NAME: my-app
      EC2_USER: ec2-user
      EC2_HOST: ${{ secrets.EC2_HOST }}
      EC2_SSH_PRIVATE_KEY: ${{ secrets.EC2_SSH_PRIVATE_KEY }}
  
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 1
      
      - uses: actions/setup-node@v2
        with: 
          node-version: '20'
      
      - name: Install dependencies
        run:  npm ci 
      
      - name: Lint
        run:  npm run eslint
      
      - name: Build
        run:  npm run build
    
      - name: Configure SSH
        run: bash scripts/configure-ssh.sh
           
      - name: Copy dist files to EC2
        run: |
          scp -r ./dist/* \
          ${{ env.EC2_USER }}@${{ secrets.EC2_HOST }}:/var/www/${{ env.APP_NAME }}
    
      - name: Run post-deploy commands on EC2
        run: bash scripts/post-deploy.sh
```

**Directory Structure**

```plaintext
.github/
  workflows/
    deploy.yml
scripts/
  configure-ssh.sh
  post-deploy.sh
```

**File configure-ssh.sh**

```bash
#!/bin/bash

# 1. Create the .ssh directory if it doesn't exist
mkdir -p ~/.ssh/

# 2. Save the private SSH key
echo "${EC2_SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa

# 3. Set secure permissions for the private key
chmod 600 ~/.ssh/id_rsa

# 4. Add the EC2 host's public key to known_hosts
ssh-keyscan -H "${EC2_HOST}" >> ~/.ssh/known_hosts

echo "SSH configuration completed successfully."
```

**File post-deploy.sh**

```bash
#!/bin/bash

# Connect to the EC2 instance and execute post-deployment commands

ssh "${EC2_USER}@${EC2_HOST}" <<EOF
echo "Deployment completed for app: ${APP_NAME}"
# Add any additional commands here, such as restarting services
EOF

echo "Post-deployment commands executed successfully."
```