provider "aws" {
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
      version = "3.70.0"
    }
  }
}
