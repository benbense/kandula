resource "tfe_workspace" "servers" {
  name         = var.servers_workspace_name
  organization = var.tfe_organization_name
  vcs_repo {
    identifier     = "${var.github_user}/${var.workspace_repo_identifier}"
    oauth_token_id = var.oauth_token_id
    branch         = var.github_branch
  }
  global_remote_state = true
  execution_mode      = "remote"
  working_directory   = var.servers_workspace_directory
  auto_apply          = var.auto_apply
}

resource "tfe_variable" "instance_type" {
  key          = "instance_type"
  value        = var.instance_type
  description  = "Instances type"
  workspace_id = tfe_workspace.servers.id
  category     = "terraform"
}

resource "tfe_variable" "bucket_name" {
  key          = "bucket_name"
  value        = var.bucket_name
  description  = "Bucket name for ALB logs"
  workspace_id = tfe_workspace.servers.id
  category     = "terraform"
}

resource "tfe_variable" "aws_acess_key" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.aws_acess_key
  description  = "AWS Acess Key"
  workspace_id = tfe_workspace.servers.id
  category     = "env"
  sensitive    = true
}

resource "tfe_variable" "aws_secret_acess_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.aws_secret_acess_key
  description  = "AWS Secret Acess Key"
  workspace_id = tfe_workspace.servers.id
  category     = "env"
  sensitive    = true
}

resource "tfe_variable" "aws_default_region" {
  key          = "AWS_DEFAULT_REGION"
  value        = var.aws_default_region
  description  = "AWS Default Region"
  workspace_id = tfe_workspace.servers.id
  category     = "env"
}

resource "tfe_variable" "vpc_workspace_name" {
  key          = "vpc_workspace_name"
  value        = var.vpc_workspace_name
  description  = "VPC Workspace Name"
  workspace_id = tfe_workspace.servers.id
  category     = "terraform"
}

resource "tfe_variable" "consul_servers_count" {
  key          = "consul_servers_count"
  value        = var.consul_servers_count
  description  = "How much Consul servers to create"
  workspace_id = tfe_workspace.servers.id
  category     = "terraform"
}

resource "tfe_variable" "jenkins_nodes_count" {
  key          = "jenkins_nodes_count"
  value        = var.jenkins_nodes_count
  description  = "How much Jenkins nodes to create"
  workspace_id = tfe_workspace.servers.id
  category     = "terraform"
}

resource "tfe_variable" "tfe_organization_name" {
  key          = "tfe_organization_name"
  value        = var.tfe_organization_name
  description  = "TFE Organization Name"
  workspace_id = tfe_workspace.servers.id
  category     = "terraform"
}

resource "tfe_variable" "server_key" {
  key          = "server_key"
  value        = var.server_key
  description  = "Public SSH key name"
  workspace_id = tfe_workspace.servers.id
  category     = "terraform"
  sensitive    = true
}
