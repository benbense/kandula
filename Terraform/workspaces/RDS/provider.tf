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

data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "${var.tfe_organization_name}"
    workspaces = {
      name = "${var.vpc_workspace_name}"
    }
  }
}

data "terraform_remote_state" "servers" {
  backend = "remote"
  config = {
    organization = "${var.tfe_organization_name}"
    workspaces = {
      name = "${var.servers_workspace_name}"
    }
  }
}
