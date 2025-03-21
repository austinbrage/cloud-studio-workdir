data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "main" {
  name         = "${var.common_name}-vm"
  zone         = var.zones[0]
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }

  network_interface {
    subnetwork = var.subnet_name
    access_config {}
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  labels = var.tags
}