# AWS Network Terraform module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) ![Amazon web services](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

This Terraform module creates essential networking resources in AWS, including a VPC, subnet, security group, internet gateway, route table, and optionally, a key pair for SSH access.

## Features
- Creates a VPC with customizable CIDR block.
- Defines a subnet within the VPC.
- Configures a security group with dynamic ingress and egress rules.
- Sets up an internet gateway and a route table for internet access.
- Optionally creates an SSH key pair.

## Usage

```hcl
module "network" {
  source = "./network"

  project_name        = "my_project"
  environment         = "dev"
  vpc_cidr_block      = "10.0.0.0/16"
  subnet_cidr_block   = "10.0.1.0/24"
  allow_ssh           = true
  allow_http          = false
  security_group_ingress = [
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]
  security_group_egress  = []
  allow_all_egress    = true
  key_name            = "my_key"
  create_key_pair     = false
  public_key_path     = "~/.ssh/id_rsa.pub"

  tags = {
    Owner = "your_email@example.com"
    Team  = "DevOps"
  }
}
```

| Name                   | Description                                                                                             | Type          | Default | Required |
|------------------------|---------------------------------------------------------------------------------------------------------|---------------|---------|----------|
| `project_name`         | Name of the cloud project.                                                                            | `string`      | `null`  | yes      |
| `environment`          | Environment of the cloud project (e.g., `dev`, `prod`, `stage`).                                      | `string`      | `null`  | yes      |
| `vpc_cidr_block`       | CIDR block for the VPC (e.g., `10.0.0.0/16`).                                                         | `string`      | `null`  | yes      |
| `subnet_cidr_block`    | CIDR block for the subnet (e.g., `10.0.1.0/24`).                                                      | `string`      | `null`  | yes      |
| `allow_ssh`            | Whether to allow SSH (port 22).                                                                        | `bool`        | `true`  | no       |
| `allow_http`           | Whether to allow HTTP (port 80).                                                                       | `bool`        | `true`  | no       |
| `allow_all_egress`     | Whether to allow all outbound traffic.                                                                 | `bool`        | `true`  | no       |
| `security_group_ingress` | Custom ingress rules for the security group.                                                           | `list(object)`| `[]`   | no       |
| `security_group_egress` | Custom egress rules for the security group.                                                            | `list(object)`| `[]`   | no       |
| `create_key_pair`      | Whether to create a new key pair.                                                                      | `bool`        | `true`  | no       |
| `key_name`             | Name of the SSH key pair.                                                                             | `string`      | `null`  | yes      |
| `public_key_path`      | Path to the public key file on the current machine.                                                     | `string`      | `null`  | no       |
| `common_tags`          | Common tags to apply to network resources, with a default value of `{ Terraform = "true" }`.            | `map(string)` | `{}`   | no       |
| `tags`                 | Tags to apply to all network resources, such as metadata or organizational information.                | `map(string)` | `{ Team = "DevOps", Owner = "someaddress@gmail.com" }` | no       |

## Outputs

| Name                  | Description                                             |
|-----------------------|---------------------------------------------------------|
| `vpc_id`              | The ID of the created VPC.                             |
| `subnet_id`           | The ID of the created subnet.                          |
| `security_group_id`   | The ID of the created security group.                  |
| `internet_gateway_id` | The ID of the created internet gateway.                |
| `route_table_id`      | The ID of the created route table.                     |
| `key_pair_id`         | The ID of the created key pair.                        |
| `key_pair_name`       | The name of the created key pair.                      |

## Resources Created
- **VPC**: A Virtual Private Cloud for your networking needs.
- **Subnet**: A subnet for your instances to reside within the VPC.
- **Security Group**: A security group with customizable ingress and egress rules.
- **Internet Gateway**: A gateway to provide internet access.
- **Route Table**: A table that routes traffic from the subnet to the internet.
- **Key Pair (optional)**: SSH key pair for accessing EC2 instances.

## License

This module is licensed under the MIT License.