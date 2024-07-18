packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/amazon"
    }

    azure = {
      version = ">= 2.0.2"
      source  = "github.com/hashicorp/azure"
    }

    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }

    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

locals {
  date             = formatdate("HHmm", timestamp())
  bucket_name      = "hashicat-${local.os_name}"
  os_name          = "ubuntu-2204"
  aws_image_name   = join("_", [local.bucket_name, "aws", local.os_name, local.date])
  azure_image_name = join("_", [local.bucket_name, "azure", local.os_name, local.date])
  gcp_image_name   = join("-", [local.bucket_name, "gcp", local.os_name, local.date])

  common_tags = {
    os         = "ubuntu"
    os-version = "22_04"
    owner      = "platform-team"
    built-by   = "packer"
    build-date = local.date
  }

  build_tags = {
    build-time   = timestamp()
    build-source = basename(path.cwd)
  }
}

source "amazon-ebs" "ubuntu-lts" {
  region = var.aws_configuration.region
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
  instance_type           = "t2.small"
  temporary_key_pair_type = "ed25519"
  ssh_username            = "ubuntu"
  ssh_agent_auth          = false
  ami_regions             = [var.aws_configuration.region]

  tags = local.common_tags
}

source "azure-arm" "ubuntu-lts" {
  client_id       = var.azure_credentials.client_id
  client_secret   = var.azure_credentials.client_secret
  subscription_id = var.azure_credentials.subscription_id
  tenant_id       = var.azure_credentials.tenant_id

  os_type         = "Linux"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_publisher = "Canonical"
  image_sku       = "22_04-lts"

  vm_size                           = "Standard_B2als_v2"
  managed_image_resource_group_name = var.azure_configuration.resource_group_name
  location                          = var.azure_configuration.location
  ssh_username                      = "azureuser"
  ssh_agent_auth                    = false

  azure_tags = local.common_tags
}

source "googlecompute" "ubuntu-lts" {
  project_id       = var.gcp_configuration.project_id
  zone             = var.gcp_configuration.zone
  credentials_file = var.gcp_configuration.credentials_file

  source_image = "ubuntu-2204-jammy-v20240614"
  ssh_username = "packer"

  image_storage_locations = ["us"]
  image_labels            = local.common_tags
}

build {
  name = "hashicat-build"

  hcp_packer_registry {
    bucket_name   = local.bucket_name
    description   = "Multi Cloud HashiCat VM Image."
    bucket_labels = local.common_tags
    build_labels  = local.build_tags
  }

  source "source.amazon-ebs.ubuntu-lts" {
    name     = "aws-ubuntu"
    ami_name = local.aws_image_name
  }

  source "source.azure-arm.ubuntu-lts" {
    name               = "azure-ubuntu"
    managed_image_name = local.azure_image_name
  }

  source "source.googlecompute.ubuntu-lts" {
    name       = "gcp-ubuntu"
    image_name = local.gcp_image_name
  }

  provisioner "ansible" {
    command       = "ansible-playbook"
    playbook_file = "main.yml"
    use_proxy     = false
  }
}
