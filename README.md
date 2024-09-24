# Cloud Studio **[Workdir]**

This repository contains the base files for the **[Cloud Studio](https://google.com/)** application

A workspace where you can store, edit, and deploy your Terraform scripts across different cloud providers.

## Getting Started

To start using the Cloud Studio Workdir on the Desktop app, follow these steps:

1. **Clone this Repository**: 
    ```bash
    git clone https://github.com/austinbrage/cloud-studio-workdir.git
    ```
## Directory Structure

The Workdir is structured to fit the Cloud Studio App requirements

```plaintext
cloud-studio-workdir/
├── aws/               # AWS provider folder 
│   └── modules/       # AWS modules for projects
│   └── projects/      # AWS projects for using terrafom
│   └── templates/     # AWS templates for new projects
├── azure/             
│   └── .../
├── google/             
│   └── .../           
│
└── README.md              # Workdir documentation
```