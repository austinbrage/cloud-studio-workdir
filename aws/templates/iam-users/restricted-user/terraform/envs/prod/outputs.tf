# Since password is set SENSITIVE to true, use "terraform output -raw password" to view the generated pass outside the app

output "user" {
  description = "User name for new specific access user."
  value       = aws_iam_user.specific_access_user.name
}

output "password" {
  description = "Random generated password for new specific access user."
  value       = aws_iam_user_login_profile.specific_access_user_login_profile.password
  sensitive   = true
}
