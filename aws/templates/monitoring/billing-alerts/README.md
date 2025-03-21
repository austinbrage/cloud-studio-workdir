# Billing alarm to monitor your estimated AWS charges

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)

This Terraform project set up billing alerts for an AWS account. It creates a CloudWatch alarm to monitor estimated charges and sends notifications via Amazon SNS when the charges exceed a specified threshold. This solution helps you stay informed about your AWS spending and avoid unexpected costs.

## Prerequisites

To enable the monitoring of estimated charges:

1. Open the AWS Billing and Cost Management console at [https://console.aws.amazon.com/costmanagement/](https://console.aws.amazon.com/costmanagement/).
2. In the navigation pane, choose **Billing Preferences**.
3. Under **Alert preferences**, choose **Edit**.
4. Select **Receive CloudWatch Billing Alerts**.
5. Select **Receive Free Tier Usage Alerts** (on new accounts).
6. Click on **Update**.

Additionally, after applying the Terraform code, you will receive an email to confirm your subscription to the SNS topic. You must confirm this subscription to start receiving billing notifications.

## Key Features

- **Customizable Threshold**: Set a custom billing threshold (in USD) to trigger the alarm.
- **Flexible Notification**: Configure an email address to receive billing alerts via Amazon SNS.
- **Configurable Period**: Define the evaluation period (in seconds) for monitoring estimated charges.
- **Currency Support**: Supports multiple currencies for billing metrics (default is USD).
- **Evaluation Periods**: Control how many consecutive periods must breach the threshold before triggering the alarm.
- **Fully Automated**: Automates the setup of CloudWatch alarms and SNS notifications without manual intervention (except for enabling billing alerts initially).
