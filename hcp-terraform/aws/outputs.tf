output "url" {
  value = module.hashicat-aws.catapp_url
}

output "image-created-at" {
  value = data.hcp_packer_artifact.hashicat-image.created_at
}
