variable "organization_name" {
  type = string
}

variable "project_name" {
  type    = string
  default = "Default Project"
}

variable "vcs_branch" {}
variable "vcs_repo" {}
variable "github_app_installation_id" {}
variable "assessments_enabled" {}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
