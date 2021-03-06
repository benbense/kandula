data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "${var.tfe_organization_name}"
    workspaces = {
      name = "${var.vpc_workspace_name}"
    }
  }
}
module "servers" {
  source                = "app.terraform.io/kandula/servers/aws"
  version               = "1.0.19"
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  available_zone_names  = data.terraform_remote_state.vpc.outputs.available_zone_names
  public_subnets_ids    = data.terraform_remote_state.vpc.outputs.public_subnets_ids
  private_subnets_ids   = data.terraform_remote_state.vpc.outputs.private_subnets_ids
  instance_profile_name = data.terraform_remote_state.vpc.outputs.instance_profile_name
  kandula_ssl_cert      = data.terraform_remote_state.vpc.outputs.kandula_ssl_cert
  route53_zone_id       = data.terraform_remote_state.vpc.outputs.route53_zone_id
  cidr_block            = data.terraform_remote_state.vpc.outputs.cidr_block
  instance_type         = var.instance_type
  bucket_name           = var.bucket_name
  consul_servers_count  = var.consul_servers_count
  jenkins_nodes_count   = var.jenkins_nodes_count
  server_key            = var.server_key
  elb_account_id        = var.elb_account_id
}
