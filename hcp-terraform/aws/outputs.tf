output "url" {
  value = module.hashicat-aws.catapp_url
}

output "image" {
  value = data.hcp_packer_artifact.hashicat-image
}
