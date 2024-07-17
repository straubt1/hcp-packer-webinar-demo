# Outputs file
output "catapp_url" {
  value = "http://${google_compute_instance.default.network_interface[0].access_config[0].nat_ip}"
}

output "catapp_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}
