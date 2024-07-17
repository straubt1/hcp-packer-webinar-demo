

resource "google_compute_instance" "default" {
  name         = "hashicat-gcp"
  machine_type = "n2-standard-2"
  zone         = var.region
  hostname     = "hashicat-gcp"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = var.image_id
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  # metadata_startup_script = "echo hi > /test.txt"
}

# Allow HTTP traffic to the instance
resource "google_compute_firewall" "http_firewall" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}