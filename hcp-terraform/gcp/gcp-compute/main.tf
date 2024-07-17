

resource "google_compute_instance" "default" {
  name         = "hashicat-gcp"
  machine_type = "n2-standard-2"
  zone         = var.region

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