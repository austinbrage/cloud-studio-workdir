# To view available regions and zones in AWS, visit:
# https://www.aws-services.info/regions.html

project_name = "billing-alerts"
environment  = "stage"

team  = "devops"
owner = "agustinbrage19@gmail.com"



/* Specific project DEFINITIONS */

user_name = "YourName"

currency           = "USD"
billing_threshold  = 5 # 5 Dollars
billing_period     = 6 # 6 Hours
evaluation_periods = 1 # Triggers the alarm on the first threshold breach
