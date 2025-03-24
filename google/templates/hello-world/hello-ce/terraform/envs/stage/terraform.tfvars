# To view available regions and zones in GCP, visit:
# https://holori.com/list-of-gcp-regions

google_project = "my-project-id"

google_region = "us-central1"
google_zones  = ["us-central1-a", "us-central1-b", "us-central1-c", "us-central1-f"]

project_name = "instance-api"
environment  = "stage"

team  = "devops"
owner = "agustinbrage19-gmail-com"



/* Specific project DEFINITIONS */

machine_type = "e2-micro"

public_key_path = "D:/my-projects/04-cloud-studio/workdir/prod/aws/keys/dev.key.pub"

subnet_ip_range    = "10.0.0.0/16"
allow_ssh_access   = true
allow_http_access  = true
http_public_access = true

# Put your team members IP addresses
team_authorized_ips = ["192.0.2.0/32"]
