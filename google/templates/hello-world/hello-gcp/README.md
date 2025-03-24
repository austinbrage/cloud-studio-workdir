# Enable multiple GCP services APIs at once

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)

This Terraform project automates the provisioning of essential Google Cloud Platform (GCP) services by enabling only the required APIs for your infrastructures on a given project.

## To be considered

Before running this project, you **must** enable the **Service Usage API** in your GCP project. Click here to enable it on your Google console, **[Enable Service Usage API](https://console.cloud.google.com/apis/library/serviceusage.googleapis.com)**.

- 📌 The Service Usage API is responsible for managing the enablement and disablement of other APIs within your project. Without this API enabled, Terraform cannot programmatically activate the required services and the deployment will fail.

Make sure to edit the terraform main content, to **enable only the APIs required** for your project to reduce security risks and prevent unnecessary costs.

- 📌 Review the locals.apis block and ensure it contains only the services your infrastructure needs.

## Why is enabling APIs required in GCP?

In GCP, every service (Compute, Storage, VPC, IAM, etc.) is exposed through an API. Any client, whether Terraform, SDKs, etc, interacts with GCP resources via these APIs. Therefore, APIs **must be explicitly enabled** at the project level for the services you intend to use.

### Reasons for Explicit API Enablement

- **Security and Access Control:** Minimizes the attack surface by enabling only necessary APIs, reducing the risk of unintentional access to unused services.
- **Cost Management:** Some APIs may incur costs upon usage. Explicitly enabling only what is required provides better budget control.
- **GCP’s Microservices Architecture:** GCP treats each service as a decoupled microservice accessible through its API.

If APIs are not enabled, Terraform operations will fail with errors similar to:

```bash
googleapi: Error 403: API [compute.googleapis.com] not enabled
```

## Alternatives

The APIs can be enabled manually, by searching for each one of them on the Google Cloud Library:

[GCP API Library Console](https://console.cloud.google.com/apis/library)

Or you can use the gcloud CLI:

```bash
gcloud services enable compute.googleapis.com sqladmin.googleapis.com --project=my-project-id
```

