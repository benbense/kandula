module "vpc" {
  source                    = ".\\modules\\terraform-tfe-vpc"
  tfe_organization_name     = var.tfe_organization_name
  github_user               = var.github_user
  oauth_token_id            = tfe_oauth_client.github_oauth.oauth_token_id
  github_branch             = var.github_branch
  availability_zones        = var.availability_zones
  vpc_name                  = var.vpc_name
  aws_acess_key             = var.aws_acess_key
  aws_secret_acess_key      = var.aws_secret_acess_key
  aws_default_region        = var.aws_default_region
  cidr_size                 = var.cidr_size
  vpc_workspace_name        = var.vpc_workspace_name
  organization_name         = var.organization_name
  workspace_repo_identifier = var.workspace_repo_identifier
  vpc_workspace_directory   = var.vpc_workspace_directory
  auto_apply                = var.auto_apply
  aws_provider_version      = var.aws_provider_version
}

module "servers" {
  source                      = ".\\modules\\terraform-tfe-servers"
  tfe_organization_name       = var.tfe_organization_name
  github_user                 = var.github_user
  oauth_token_id              = tfe_oauth_client.github_oauth.oauth_token_id
  github_branch               = var.github_branch
  aws_acess_key               = var.aws_acess_key
  aws_default_region          = var.aws_default_region
  aws_secret_acess_key        = var.aws_secret_acess_key
  bucket_name                 = var.bucket_name
  instance_type               = var.instance_type
  servers_workspace_name      = var.servers_workspace_name
  vpc_workspace_name          = var.vpc_workspace_name
  workspace_repo_identifier   = var.workspace_repo_identifier
  servers_workspace_directory = var.servers_workspace_directory
  organization_name           = var.organization_name
  auto_apply                  = var.auto_apply
  consul_servers_count        = var.consul_servers_count
  jenkins_nodes_count         = var.jenkins_nodes_count
  aws_provider_version        = var.aws_provider_version

  depends_on = [
    module.vpc
  ]
}

resource "tfe_run_trigger" "vpc_creation" {
  workspace_id  = module.servers.servers_workspace_id
  sourceable_id = module.vpc.vpc_workspace_id
}
