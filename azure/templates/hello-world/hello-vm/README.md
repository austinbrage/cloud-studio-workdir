# Deploy VM Instance with Full Network Setup

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

This Terraform project sets up a complete AZURE network infrastructure, including a resource group, virtual network, subnet, network security group, public IP. and a network interface. Provisioning a Linux VM instance within the subnet, accessible via the internet and SSH.

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

For pipelines to keep the content of the VM automatically updated, a Github Action can be used. Through the values of **VM_SSH_PRIVATE_KEY** and **VM_HOST** (or public ip) stored in Github Secrets to connect to that instance.

### IMPORTANT

Since this project only allow the IP addresses of the team members to connect through SSH, this Github Workflow will fail unless...

1. Change the value of **source_address_prefixes** to ["*"] on the allow-ssh rule inside the network module to allow anyone to connect to the VM.
2. Reconfigure this worflow and install the Github runner on the VM to use it as a **self-hosted runner**.
3. Use Azure DevOps with **Managed Identity** to access the VM without SSH.

```yaml
name: Deployment on AZURE VM through SSH

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      APP_NAME: my-app
      VM_USER: ubuntu
      VM_HOST: ${{ secrets.VM_HOST }}
      VM_SSH_PRIVATE_KEY: ${{ secrets.VM_SSH_PRIVATE_KEY }}
  
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
           
      - name: Copy dist files to VM
        run: |
          scp -r ./dist/* \
          ${{ env.VM_USER }}@${{ secrets.VM_HOST }}:/var/www/${{ env.APP_NAME }}
    
      - name: Run post-deploy commands on VM
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
echo "${VM_SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa

# 3. Set secure permissions for the private key
chmod 600 ~/.ssh/id_rsa

# 4. Add the VM host's public key to known_hosts
ssh-keyscan -H "${VM_HOST}" >> ~/.ssh/known_hosts

echo "SSH configuration completed successfully."
```

**File post-deploy.sh**

```bash
#!/bin/bash

# Connect to the VM instance and execute post-deployment commands

ssh "${VM_USER}@${VM_HOST}" <<EOF
echo "Deployment completed for app: ${APP_NAME}"
# Add any additional commands here, such as restarting services
EOF

echo "Post-deployment commands executed successfully."
```