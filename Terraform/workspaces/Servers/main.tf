data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "${var.organization_name}"
    workspaces = {
      name = "${var.vpc_workspace_name}"
    }
  }
}
module "servers" {
  source               = "app.terraform.io/opsschool-ben/servers/aws"
  version              = var.servers_module_version
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
  available_zone_names = data.terraform_remote_state.vpc.outputs.available_zone_names
  public_subnets_ids   = data.terraform_remote_state.vpc.outputs.public_subnets_ids
  private_subnets_ids  = data.terraform_remote_state.vpc.outputs.private_subnets_ids
  instance_type        = var.instance_type
  bucket_name          = var.bucket_name
  consul_servers_count = var.consul_servers_count
  jenkins_nodes_count  = var.jenkins_nodes_count
}
