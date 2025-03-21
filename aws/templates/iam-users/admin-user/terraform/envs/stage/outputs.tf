# Since password is set SENSITIVE to true, use "terraform output -raw password" to view the generated pass outside the app

output "user" {
  description = "User name for new admin user."
  value       = aws_iam_user.admin_user.name
}

output "password" {
  description = "Random generated password for new admin user."
  value       = aws_iam_user_login_profile.admin_user_login_profile.password
  sensitive   = true
}