# Static Website with a S3 bucket and Cloudfront CDN

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Amazon S3](https://img.shields.io/badge/Amazon%20S3-FF9900?style=for-the-badge&logo=amazons3&logoColor=white)

This Terraform project creates an S3 bucket for hosting a static website, configures CloudFront as a CDN for content delivery, and uses Route 53 for domain management.

## To be considered

Before using this project, **the domain** must be registered in Route 53 for the project to work properly. This is required because the module creates a hosted zone and uses Route 53 records to validate the ACM certificate.

- The **ACM certificate** is validated using DNS records created in Route 53. Without this validation, the certificate cannot be used.

### Using a third-party DNS provider

If your domain is registered with a **third-party provider** (GoDaddy, Namecheap, Cloudflare, etc.), you must manually add the required CNAME records for ACM validation. You can retrieve these records from the module output.

- Copy the **CNAME records** provided in the output and add them to your DNS provider's configuration. The ACM certificate will only be validated once these records are correctly set up.

![Diagram](https://miro.medium.com/v2/resize:fit:640/format:webp/0*kwX70Czd5rFbeBx0.png)

## Key Features

- **Static Website Hosting with S3**: Stores and serves static files efficiently.
- **Global Content Delivery with CloudFront**: Improves speed and performance by caching content closer to users.
- **Custom Domain with Route 53**: Manages DNS records and enables a custom domain name.
- **SSL/TLS Encryption**: Secures traffic using an AWS Certificate Manager (ACM) SSL certificate.

## CI/CD Workflow

For pipelines to keep the content of the S3 updated, a Github Action can be used. Through credentials generated on Aws console by a user with permissions of **PutObject** and **PutObjectAcl** on that bucket.

```yaml
name: Deploy to S3

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Install dependencies and build
        run: |
          npm install
          npm run build

      - name: Upload dist folder to S3
        uses: shallwefootball/s3-upload-action@master
        with:
          aws_bucket: ${{ secrets.AWS_BUCKET }}
          aws_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          source_dir: 'dist'
```

