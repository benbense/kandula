terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.27.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "3.70.0"
    }
  }
}

provider "tfe" {
  token = var.tfe_token
}

provider "aws" {
  region     = var.aws_default_region
  access_key = var.aws_acess_key
  secret_key = var.aws_secret_acess_key
}

resource "tfe_oauth_client" "github_oauth" {
  organization     = var.tfe_organization_name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_pat
  service_provider = "github"
}
