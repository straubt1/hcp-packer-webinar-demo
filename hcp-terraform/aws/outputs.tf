output "url" {
  value = module.hashicat-aws.catapp_url
}

output "image-created-at" {
  value = data.hcp_packer_artifact.hashicat-image.created_at
}

output "debug"{
  value = {
    a = data.hcp_packer_artifact.hashicat-image
    b = data.hcp_packer_version.hashicat-image
  }
}