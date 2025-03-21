# S3 Public Read Bucket

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Amazon S3](https://img.shields.io/badge/Amazon%20S3-FF9900?style=for-the-badge&logo=amazons3&logoColor=white)

This Terraform project provisions an AWS S3 bucket with public access and automatically uploads local files. Attaching an S3 bucket policy to allow public read access to the uploaded objects.

## Key Features

- **Unique Bucket Provisioning:** Creates an S3 bucket with a unique name based on the project and environment.
- **Public Access Configuration:** Modifies S3 bucket settings and adds IAM policies to allow public access.
- **File Uploads:** Automatically uploads files from a local directory to the S3 bucket.

## Use Cases

- **Hosting Static Files:** Serve images, documents, and other public assets with a public URL.  
- **Public Dataset Storage:** Share research, analytics, or educational datasets.  
- **Static Website Hosting:** Store and serve HTML, CSS, and JS files for static webpages.  
- **Public API Resources:** Host JSON, XML, or other structured data for integrations.  
- **Software Update Distribution:** Store update files for desktop apps, enabling seamless downloads.  
