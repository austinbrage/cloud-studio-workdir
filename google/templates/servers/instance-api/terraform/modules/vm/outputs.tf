output "username" {
  description = "Username of the CE instance"
  value       = "ubuntu"
}

output "public_ip" {
  description = "Public IP of the deployed VM"
  value       = google_compute_instance.main.network_interface[0].access_config[0].nat_ip
}