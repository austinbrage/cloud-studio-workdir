# To view available regions and zones in AZURE, visit:
# https://holori.com/list-of-all-azure-regions-and

azure_location = "East US"
availability_zones = ["1", "2", "3"]

project_name = "hello-vm"
environment = "stage"

team = "devops"
owner = "agustinbrage19@gmail.com"



/* Specific project DEFINITIONS */

instance_size = "Standard_B1s"
username = "adminuser"
public_key_path = "D:/my-projects/04-cloud-studio/workdir/prod/azure/keys/dev.key.pub"

vnet_ip_range = "10.123.0.0/16"

allow_ssh_access = true
allow_http_access = true
http_public_access = true

# Put your team members IP addresses
team_authorized_ips = ["192.0.2.0"]