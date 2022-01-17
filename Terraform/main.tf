module "vpc" {
  source                  = ".\\modules\\terraform-tfe-vpc"
  tfe_organization_name   = var.tfe_organization_name
  github_username         = var.github_username
  oauth_token_id          = tfe_oauth_client.github_oauth.oauth_token_id
  github_branch           = var.github_branch
  availability_zones      = var.availability_zones
  vpc_name                = var.vpc_name
  aws_acess_key           = var.aws_acess_key
  aws_secret_acess_key    = var.aws_secret_acess_key
  aws_default_region      = var.aws_default_region
  cidr_size               = var.cidr_size
  vpc_workspace_name      = var.vpc_workspace_name
  github_repository_name  = var.github_repository_name
  vpc_workspace_directory = var.vpc_workspace_directory
  auto_apply              = var.auto_apply
  cert_body               = "${data.template_file.cert_body.rendered}"
  cert_private_key        = "${data.template_file.cert_private_key.rendered}"
}

module "servers" {
  source                      = ".\\modules\\terraform-tfe-servers"
  tfe_organization_name       = var.tfe_organization_name
  github_username             = var.github_username
  oauth_token_id              = tfe_oauth_client.github_oauth.oauth_token_id
  github_branch               = var.github_branch
  aws_acess_key               = var.aws_acess_key
  aws_default_region          = var.aws_default_region
  aws_secret_acess_key        = var.aws_secret_acess_key
  bucket_name                 = var.bucket_name
  instance_type               = var.instance_type
  servers_workspace_name      = var.servers_workspace_name
  vpc_workspace_name          = var.vpc_workspace_name
  github_repository_name      = var.github_repository_name
  servers_workspace_directory = var.servers_workspace_directory
  auto_apply                  = var.auto_apply
  consul_servers_count        = var.consul_servers_count
  jenkins_nodes_count         = var.jenkins_nodes_count
  elb_account_id              = var.elb_account_id
  server_key                  = aws_key_pair.server_key.key_name

  depends_on = [
    module.vpc
  ]
}

module "eks" {
  source                         = ".\\modules\\terraform-tfe-eks"
  tfe_organization_name          = var.tfe_organization_name
  github_username                = var.github_username
  oauth_token_id                 = tfe_oauth_client.github_oauth.oauth_token_id
  github_branch                  = var.github_branch
  aws_acess_key                  = var.aws_acess_key
  aws_default_region             = var.aws_default_region
  aws_secret_acess_key           = var.aws_secret_acess_key
  kubernetes_workspace_name      = var.kubernetes_workspace_name
  vpc_workspace_name             = var.vpc_workspace_name
  github_repository_name         = var.github_repository_name
  kubernetes_workspace_directory = var.kubernetes_workspace_directory
  auto_apply                     = var.auto_apply
  k8s_service_account_namespace  = var.k8s_service_account_namespace
  k8s_service_account_name       = var.k8s_service_account_name
  servers_workspace_name         = var.servers_workspace_name
}

resource "tls_private_key" "server_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "server_key" {
  public_key = tls_private_key.server_key.public_key_openssh
}

resource "local_file" "server_key" {
  sensitive_content = tls_private_key.server_key.private_key_pem
  filename          = var.private_key_path
}

data "template_file" "cert_body" {
  template = "${file("SSL/selfsigned.pem")}"
}

data "template_file" "cert_body" {
  template = "${file("SSL/private.pem")}"
}