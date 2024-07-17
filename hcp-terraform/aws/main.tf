data "hcp_packer_artifact" "hashicat-image" {
  bucket_name  = "hashicat-ubuntu-2204"
  channel_name = "release"
  platform     = "aws"
  region       = var.region
}

data "hcp_packer_version" "hashicat-image" {
  bucket_name  = "hashicat-ubuntu-2204"
  channel_name = "release"
}

module "hashicat-aws" {
  source = "./aws-compute"

  instance_ami = data.hcp_packer_artifact.hashicat-image.external_identifier
  region       = var.region
}
