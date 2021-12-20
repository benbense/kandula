resource "tfe_registry_module" "aws-vpc" {
  vcs_repo {
    display_identifier = "benbense/terraform-aws-vpc"
    identifier         = "benbense/terraform-aws-vpc"
    oauth_token_id     = tfe_oauth_client.github_oauth.oauth_token_id
  }
}

resource "tfe_registry_module" "aws-ec2" {
  vcs_repo {
    display_identifier = "benbense/terraform-aws-ec2"
    identifier         = "benbense/terraform-aws-ec2"
    oauth_token_id     = tfe_oauth_client.github_oauth.oauth_token_id
  }
}


