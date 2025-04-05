# Cloud Studio **[Workdir]**

This repository contains the base files for the **[Cloud Studio](https://cloudstudiopro.app)** application

A workspace where you can store, edit, and deploy your Terraform and Ansible projects across different cloud providers.

## Directory Structure

The Workdir is structured to fit the Cloud Studio App requirements

```plaintext
cloud-studio-workdir/
├── aws/               # AWS provider folder 
│   └── roles/         # AWS ansible roles for projects
│   └── modules/       # AWS terraform modules for projects
│   └── projects/      # AWS projects for using terrafom/ansible
│   └── templates/     # AWS templates for new projects
├── azure/             
│   └── .../
├── google/             
│   └── .../           
│
└── README.md          # Workdir documentation
```
