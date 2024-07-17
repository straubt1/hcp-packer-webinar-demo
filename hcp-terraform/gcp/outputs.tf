output "url" {
  value = module.hashicat-gcp.catapp_url
}

output "image-version" {
  value = data.hcp_packer_version.hashicat-image.name
}
