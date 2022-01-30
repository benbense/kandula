resource "tfe_workspace" "rds" {
  name         = var.rds_workspace_name
  organization = var.tfe_organization_name
  vcs_repo {
    identifier     = "${var.github_username}/${var.github_repository_name}"
    oauth_token_id = var.oauth_token_id
    branch         = var.github_branch
  }
  global_remote_state = true
  execution_mode      = "remote"
  working_directory   = var.rds_workspace_directory
  auto_apply          = var.auto_apply
  queue_all_runs      = false
}

resource "tfe_variable" "rds_workspace_name" {
  key          = "rds_workspace_name"
  value        = var.rds_workspace_name
  description  = "RDS Workspace name"
  workspace_id = tfe_workspace.rds.id
  category     = "env"
}

resource "tfe_variable" "aws_region" {
  key          = "aws_region"
  value        = var.aws_default_region
  description  = "AWS Default Region"
  workspace_id = tfe_workspace.rds.id
  category     = "terraform"
}

resource "tfe_variable" "vpc_workspace_name" {
  key          = "vpc_workspace_name"
  value        = var.vpc_workspace_name
  description  = "VPC Workspace Name"
  workspace_id = tfe_workspace.rds.id
  category     = "terraform"
}

resource "tfe_variable" "servers_workspace_name" {
  key          = "servers_workspace_name"
  value        = var.servers_workspace_name
  description  = "Servers Workspace Name"
  workspace_id = tfe_workspace.rds.id
  category     = "terraform"
}


resource "tfe_variable" "tfe_organization_name" {
  key          = "tfe_organization_name"
  value        = var.tfe_organization_name
  description  = "TFE Organization Name"
  workspace_id = tfe_workspace.rds.id
  category     = "terraform"
}

resource "tfe_variable" "aws_acess_key" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.aws_acess_key
  description  = "AWS Acess Key"
  workspace_id = tfe_workspace.rds.id
  category     = "env"
  sensitive    = true
}

resource "tfe_variable" "aws_secret_acess_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.aws_secret_acess_key
  description  = "AWS Secret Acess Key"
  workspace_id = tfe_workspace.rds.id
  category     = "env"
  sensitive    = true
}

resource "tfe_variable" "aws_default_region" {
  key          = "AWS_DEFAULT_REGION"
  value        = var.aws_default_region
  description  = "AWS Default Region"
  workspace_id = tfe_workspace.rds.id
  category     = "env"
}
