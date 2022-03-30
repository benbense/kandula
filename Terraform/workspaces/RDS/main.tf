data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "${var.tfe_organization_name}"
    workspaces = {
      name = "${var.vpc_workspace_name}"
    }
  }
}
module "rds" {
  source             = "app.terraform.io/kandula/rds/aws"
  version            = "1.0.1"
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets_ids        = data.terraform_remote_state.vpc.outputs.public_subnets_ids
  route53_zone_id    = data.terraform_remote_state.vpc.outputs.route53_zone_id
  db_identifier_name = var.db_identifier_name
  engine_version     = var.engine_version
  instance_class     = var.instance_class
  db_username        = var.db_username
  db_password        = var.db_password
}
