resource "tfe_workspace" "vpc" {
  name         = var.vpc_workspace_name
  organization = var.tfe_organization_name
  vcs_repo {
    identifier     = "${var.github_username}/${var.github_repository_name}"
    oauth_token_id = var.oauth_token_id
    branch         = var.github_branch
  }
  global_remote_state = true
  execution_mode      = "remote"
  working_directory   = var.vpc_workspace_directory
  auto_apply          = var.auto_apply
  queue_all_runs      = false
}

resource "tfe_variable" "availability_zones" {
  key          = "availability_zones"
  value        = var.availability_zones
  description  = "Availability zones to account for"
  workspace_id = tfe_workspace.vpc.id
  category     = "terraform"
}

resource "tfe_variable" "cidr_size" {
  key          = "cidr_size"
  value        = var.cidr_size
  description  = "CIDR Size"
  workspace_id = tfe_workspace.vpc.id
  category     = "terraform"
}

resource "tfe_variable" "vpc_name" {
  key          = "vpc_name"
  value        = var.vpc_name
  description  = "VPC Name"
  workspace_id = tfe_workspace.vpc.id
  category     = "terraform"
}

resource "tfe_variable" "aws_acess_key" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.aws_acess_key
  description  = "AWS Acess Key"
  workspace_id = tfe_workspace.vpc.id
  category     = "env"
  sensitive    = true
}

resource "tfe_variable" "aws_secret_acess_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.aws_secret_acess_key
  description  = "AWS Secret Acess Key"
  workspace_id = tfe_workspace.vpc.id
  category     = "env"
  sensitive    = true
}

resource "tfe_variable" "aws_default_region" {
  key          = "AWS_DEFAULT_REGION"
  value        = var.aws_default_region
  description  = "AWS Default Region"
  workspace_id = tfe_workspace.vpc.id
  category     = "env"
}

resource "tfe_variable" "cert_body" {
  key          = "cert_body"
  value        = var.cert_body
  description  = "SSL Certificate Body"
  workspace_id = tfe_workspace.vpc.id
  category     = "terraform"
  sensitive    = true
}

resource "tfe_variable" "cert_private_key" {
  key          = "cert_private_key"
  value        = var.cert_private_key
  description  = "SSL Certificate PK"
  workspace_id = tfe_workspace.vpc.id
  category     = "terraform"
  sensitive    = true
}