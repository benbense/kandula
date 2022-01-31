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

resource "tfe_variable" "vpc_workspace_name" {
  key          = "vpc_workspace_name"
  value        = var.vpc_workspace_name
  description  = "VPC Workspace Name"
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

resource "tfe_variable" "rds_ingress_ports" {
  key          = "rds_ingress_ports"
  value        = var.rds_ingress_ports
  description  = "Postgres RDS ingress ports"
  workspace_id = tfe_workspace.rds.id
  category     = "terraform"
}

resource "tfe_variable" "db_identifier_name" {
  key          = "db_identifier_name"
  value        = var.db_identifier_name
  description  = "DB Identifier name"
  workspace_id = tfe_workspace.rds.id
  category     = "terraform"
}

resource "tfe_variable" "engine_version" {
  key          = "engine_version"
  value        = var.engine_version
  description  = "DB Engine Version"
  workspace_id = tfe_workspace.rds.id
  category     = "terraform"
}

resource "tfe_variable" "instance_class" {
  key          = "instance_class"
  value        = var.instance_class
  description  = "DB Instance class"
  workspace_id = tfe_workspace.rds.id
  category     = "terraform"
}

resource "tfe_variable" "db_username" {
  key          = "db_username"
  value        = var.db_username
  description  = "DB Username"
  workspace_id = tfe_workspace.rds.id
  category     = "terraform"
}
