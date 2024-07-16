data "tfe_organization" "organization" {
  name = var.organization_name
}

resource "tfe_project" "project" {
  name         = var.project_name
  organization = var.organization_name
  description  = "Project for Packer and Terraform Demo"
}

resource "tfe_workspace" "workspace" {
  name         = var.workspace_name
  organization = data.tfe_organization.organization.name
  project_id   = tfe_project.project.id
}

resource "tfe_variable" "tfc_aws_provider_auth" {
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  category     = "env"
  workspace_id = tfe_workspace.workspace.id
  sensitive    = false
}

resource "tfe_variable" "tfc_aws_workload_identity_audience" {
  key          = "TFC_AWS_WORKLOAD_IDENTITY_AUDIENCE"
  value        = local.workload_identity_audience
  category     = "env"
  workspace_id = tfe_workspace.workspace.id
  sensitive    = false
}

resource "tfe_variable" "tfc_aws_run_role_arn" {
  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = aws_iam_role.tfc_role.arn
  category     = "env"
  workspace_id = tfe_workspace.workspace.id
  sensitive    = false
}
