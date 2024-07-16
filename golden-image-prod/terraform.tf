terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  cloud {
    organization = "terraform-tom"

    workspaces {
      name = "golden-image-prod"
    }
  }
}
