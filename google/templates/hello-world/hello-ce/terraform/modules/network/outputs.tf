output "subnet_name" {
  description = "Name of the subnetwork created."
  value       = google_compute_subnetwork.main.name
}