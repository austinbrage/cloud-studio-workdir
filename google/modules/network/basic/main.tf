resource "google_compute_network" "main" {
  name         = "${var.common_name}-vpc"
  routing_mode = "GLOBAL"

  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  name          = "${var.common_name}-subnet"
  ip_cidr_range = var.subnet_ip_range

  network = google_compute_network.main.id
  region  = var.region
}

resource "google_compute_firewall" "allow-ssh" {
  count = var.allow_ssh_access ? 1 : 0

  name    = "${var.common_name}-allow-ssh"
  network = google_compute_network.main.name

  direction     = "INGRESS"
  source_ranges = var.team_authorized_ips

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow-http" {
  count = var.allow_http_access ? 1 : 0

  name    = "${var.common_name}-allow-http"
  network = google_compute_network.main.name

  direction     = "INGRESS"
  source_ranges = var.http_public_access ? ["0.0.0.0/0"] : var.team_authorized_ips

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

resource "google_compute_firewall" "allow-egress" {
  name    = "${var.common_name}-allow-all-egress"
  network = google_compute_network.main.name

  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "all"
  }
}