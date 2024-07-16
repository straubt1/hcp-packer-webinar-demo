packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }

    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

#Variables cannot be updated during runtime
#This variable is used for the ami_name
variable "ami_prefix" {
  type    = string
  default = "hashicat-demo"
}

#Locals are useful when you need to format commanly used values
#
locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "${var.ami_prefix}-${local.timestamp}"
  instance_type = "t2.small"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      # name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      # name                = "ubuntu-pro-server/images/hvm-ssd/ubuntu-xenial-16.04-amd64-pro-server-*"
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }

  ssh_username = "ubuntu"
}

build {
  name = "hashicat-demo-image"

  hcp_packer_registry {
    bucket_name = "hashicat-demo"
    description = "EC2 image with apache web server on it and hashicat app"

    bucket_labels = {
      "os" = "Ubuntu",
    }

    build_labels = {
      "build-time" = timestamp()
    }
  }

  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "file" {
    source      = "./website.html"
    destination = "/home/ubuntu/"
  }

  provisioner "ansible" {
    command       = "ansible-playbook"
    playbook_file = "main.yml"
    use_proxy     = false
    # user          = "" # Do not set this here, it is different in AWS and Azure
  }

  # provisioner "shell" {
  #   inline = [
  #     "echo '*** Installing updates'",
  #     "sudo apt-get update -y",
  #     "echo '*** Installing apache2'",
  #     "sudo apt-get install apache2 -y",
  #     "echo '*** Completed Installing apache2'",
  #     "sudo mv /home/ubuntu/website.html /var/www/html/index.html"
  #   ]
  # }
}