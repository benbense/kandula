resource "tfe_registry_module" "aws-vpc" {
  vcs_repo {
    display_identifier = "benbense/terraform-aws-vpc"
    identifier         = "benbense/terraform-aws-vpc"
    oauth_token_id     = tfe_oauth_client.github_oauth.oauth_token_id
  }
}

resource "tfe_registry_module" "aws-servers" {
  vcs_repo {
    display_identifier = "benbense/terraform-aws-servers"
    identifier         = "benbense/terraform-aws-servers"
    oauth_token_id     = tfe_oauth_client.github_oauth.oauth_token_id
  }
}

resource "tfe_registry_module" "aws-rds" {
  vcs_repo {
    display_identifier = "benbense/terraform-aws-rds"
    identifier         = "benbense/terraform-aws-rds"
    oauth_token_id     = tfe_oauth_client.github_oauth.oauth_token_id
  }
}


