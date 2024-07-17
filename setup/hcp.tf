resource "tfe_project" "project" {
  name         = var.project_name
  organization = var.organization_name
  description  = "Project HashiCat for Packer and Terraform Demo"
}

resource "tfe_workspace" "azure" {
  name         = "hashicat-azure"
  project_id   = tfe_project.project.id
  organization = var.organization_name

  working_directory = "hcp-terraform/azure/"
  vcs_repo {
    identifier = var.vcs_repo
    branch = var.vcs_branch
    github_app_installation_id = var.github_app_installation_id
  }
  trigger_patterns = ["hcp-terraform/azure/"]
}
resource "tfe_workspace" "gcp" {
  name         = "hashicat-gcp"
  project_id   = tfe_project.project.id
  organization = var.organization_name

  working_directory = "hcp-terraform/gcp/"
  vcs_repo {
    identifier = var.vcs_repo
    branch = var.vcs_branch
    github_app_installation_id = var.github_app_installation_id
  }
  trigger_patterns = ["hcp-terraform/gcp/"]
}
resource "tfe_workspace" "aws" {
  name         = "hashicat-aws"
  project_id   = tfe_project.project.id
  organization = var.organization_name

  working_directory = "hcp-terraform/aws/"
  vcs_repo {
    identifier = var.vcs_repo
    branch = var.vcs_branch
    github_app_installation_id = var.github_app_installation_id
  }
  trigger_patterns = ["hcp-terraform/aws/"]
}

# resource "tfe_variable" "tfc_aws_provider_auth" {
#   key          = "TFC_AWS_PROVIDER_AUTH"
#   value        = "true"
#   category     = "env"
#   workspace_id = tfe_workspace.aws.id
#   sensitive    = false
# }

# resource "tfe_variable" "tfc_aws_workload_identity_audience" {
#   key          = "TFC_AWS_WORKLOAD_IDENTITY_AUDIENCE"
#   value        = local.workload_identity_audience
#   category     = "env"
#   workspace_id = tfe_workspace.aws.id
#   sensitive    = false
# }

# resource "tfe_variable" "tfc_aws_run_role_arn" {
#   key          = "TFC_AWS_RUN_ROLE_ARN"
#   value        = aws_iam_role.tfc_role.arn
#   category     = "env"
#   workspace_id = tfe_workspace.aws.id
#   sensitive    = false
# }
