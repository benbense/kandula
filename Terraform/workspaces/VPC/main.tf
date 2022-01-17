module "vpc" {
  source             = "app.terraform.io/kandula/vpc/aws"
  version            = "1.0.7"
  vpc_name           = var.vpc_name
  cidr_size          = var.cidr_size
  availability_zones = var.availability_zones
  cert_body = var.cert_body
  cert_private_key = var.cert_private_key
}
