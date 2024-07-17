# Outputs file
output "catapp_url" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}

output "catapp_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].public_ptr_domain_name
}
