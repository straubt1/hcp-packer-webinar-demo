terraform {
  required_providers {
    tfe = {
      version = ">= 0.40.0"
      source  = "hashicorp/tfe"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
