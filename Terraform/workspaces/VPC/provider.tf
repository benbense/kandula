provider "aws" {
  region = var.region
}

terraform {
  backend "remote" {
    organization = var.organization_name
    workspaces {
      name = var.vpc_workspace_name
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "${var.aws_provider_version}"
    }
  }
}
