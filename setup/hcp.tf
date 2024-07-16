resource "tfe_project" "project" {
  name         = var.project_name
  organization = var.organization_name
  description  = "Project HashiCat for Packer and Terraform Demo"
}

resource "tfe_workspace" "azure" {
  name         = "hashicats-azure"
  project_id   = tfe_project.project.id
  organization = var.organization_name
}
resource "tfe_workspace" "gcp" {
  name         = "hashicats-gcp"
  project_id   = tfe_project.project.id
  organization = var.organization_name
}
resource "tfe_workspace" "aws" {
  name         = "hashicats-aws"
  project_id   = tfe_project.project.id
  organization = var.organization_name
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
