locals {
  bucket_name  = "hashicat-ubuntu-2204"
  channel_name = "release"
}

data "hcp_packer_artifact" "hashicat-image" {
  bucket_name  = local.bucket_name
  channel_name = local.channel_name
  platform     = "gce"
  region       = var.region
}

data "hcp_packer_version" "hashicat-image" {
  bucket_name  = local.bucket_name
  channel_name = local.channel_name
}

module "hashicat-gcp" {
  source = "./gcp-compute"

  image_id = data.hcp_packer_artifact.hashicat-image.external_identifier
  region       = var.region
}
