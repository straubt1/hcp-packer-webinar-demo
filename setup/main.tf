# locals {
#   my_email                   = split("/", data.aws_caller_identity.current.arn)[2]
#   tfc_hostname               = "app.terraform.io"
#   workload_identity_audience = "aws.workload.identity"
# }

# data "aws_caller_identity" "current" {}

# data "tls_certificate" "tfc_certificate" {
#   url = "https://${local.tfc_hostname}"
# }

# resource "aws_iam_openid_connect_provider" "tfc_provider" {
#   url             = "https://${local.tfc_hostname}"
#   client_id_list  = [local.workload_identity_audience]
#   thumbprint_list = ["${data.tls_certificate.tfc_certificate.certificates.0.sha1_fingerprint}"]
# }

# data "aws_iam_policy_document" "tfc_role_trust_policy" {
#   statement {
#     effect  = "Allow"
#     actions = ["sts:AssumeRoleWithWebIdentity"]

#     principals {
#       type        = "Federated"
#       identifiers = [aws_iam_openid_connect_provider.tfc_provider.arn]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "${local.tfc_hostname}:aud"
#       values   = [local.workload_identity_audience]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "${local.tfc_hostname}:sub"
#       values = [
#         "organization:${data.tfe_organization.organization.name}:project:${var.project_name}:workspace:${tfe_workspace.workspace.name}:run_phase:plan",
#         "organization:${data.tfe_organization.organization.name}:project:${var.project_name}:workspace:${tfe_workspace.workspace.name}:run_phase:apply"
#       ]
#     }
#   }
# }

# resource "aws_iam_role" "tfc_role" {
#   name               = "tfc-workload-identity-${local.my_email}"
#   assume_role_policy = data.aws_iam_policy_document.tfc_role_trust_policy.json
# }

# # this is the actual policy to do stuff on AWS
# # change it according to your needs

# resource "aws_iam_policy" "tfc_policy" {
#   name        = "tfc-policy"
#   description = "TFC run policy"

#   policy = <<-EOF
#   {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "ec2:*"
#       ],
#       "Resource": "*"
#     }
#   ]
#   }
#   EOF
# }

# resource "aws_iam_role_policy_attachment" "tfc_policy_attachment" {
#   role       = aws_iam_role.tfc_role.name
#   policy_arn = aws_iam_policy.tfc_policy.arn
# }
