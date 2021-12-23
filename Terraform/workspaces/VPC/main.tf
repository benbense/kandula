module "vpc" {
  source             = "app.terraform.io/opsschool-ben/vpc/aws"
  version            = var.servers_module_version
  vpc_name           = var.vpc_name
  cidr_size          = var.cidr_size
  availability_zones = var.availability_zones
}
