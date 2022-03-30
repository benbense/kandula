<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_variable.availability_zones](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_acess_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_default_region](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_secret_acess_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.cert_body](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.cert_private_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.cidr_size](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.vpc_name](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.vpc](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Whether to automatically apply changes when a Terraform plan is successful | `any` | n/a | yes |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones to account for | `number` | n/a | yes |
| <a name="input_aws_acess_key"></a> [aws\_acess\_key](#input\_aws\_acess\_key) | AWS Acess Key | `string` | n/a | yes |
| <a name="input_aws_default_region"></a> [aws\_default\_region](#input\_aws\_default\_region) | AWS Default Region | `string` | n/a | yes |
| <a name="input_aws_secret_acess_key"></a> [aws\_secret\_acess\_key](#input\_aws\_secret\_acess\_key) | AWS Secret Acess Key | `string` | n/a | yes |
| <a name="input_cert_body"></a> [cert\_body](#input\_cert\_body) | SSL Certificate Body | `string` | n/a | yes |
| <a name="input_cert_private_key"></a> [cert\_private\_key](#input\_cert\_private\_key) | SSL Certificate PK | `string` | n/a | yes |
| <a name="input_cidr_size"></a> [cidr\_size](#input\_cidr\_size) | CIDR Size | `string` | n/a | yes |
| <a name="input_github_branch"></a> [github\_branch](#input\_github\_branch) | Github Branch Name | `string` | n/a | yes |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | Github repo identifier for Workspace creation | `string` | n/a | yes |
| <a name="input_github_username"></a> [github\_username](#input\_github\_username) | Github Username | `string` | n/a | yes |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | Github OAuth Token ID | `any` | n/a | yes |
| <a name="input_tfe_organization_name"></a> [tfe\_organization\_name](#input\_tfe\_organization\_name) | Terrafrom Cloud Organization Name | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name | `string` | n/a | yes |
| <a name="input_vpc_workspace_directory"></a> [vpc\_workspace\_directory](#input\_vpc\_workspace\_directory) | Working directory for vpc module | `string` | n/a | yes |
| <a name="input_vpc_workspace_name"></a> [vpc\_workspace\_name](#input\_vpc\_workspace\_name) | VPC Workspace name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_workspace_id"></a> [vpc\_workspace\_id](#output\_vpc\_workspace\_id) | VPC Workspace ID |
<!-- END_TF_DOCS -->