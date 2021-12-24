module "vpc" {
  source             = "app.terraform.io/kandula/vpc/aws"
  version            = "1.0.5"
  vpc_name           = var.vpc_name
  cidr_size          = var.cidr_size
  availability_zones = var.availability_zones
}
