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
| [tfe_variable.aws_acess_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_default_region](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_region](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_secret_acess_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.k8s_service_account_name](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.k8s_service_account_namespace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.kubernetes_workspace_name](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.servers_workspace_name](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfe_organization_name](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.vpc_workspace_name](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.kubernetes](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Whether to automatically apply changes when a Terraform plan is successful | `any` | n/a | yes |
| <a name="input_aws_acess_key"></a> [aws\_acess\_key](#input\_aws\_acess\_key) | AWS Acess Key | `string` | n/a | yes |
| <a name="input_aws_default_region"></a> [aws\_default\_region](#input\_aws\_default\_region) | AWS Default Region | `string` | n/a | yes |
| <a name="input_aws_secret_acess_key"></a> [aws\_secret\_acess\_key](#input\_aws\_secret\_acess\_key) | AWS Secret Acess Key | `string` | n/a | yes |
| <a name="input_github_branch"></a> [github\_branch](#input\_github\_branch) | Github Branch Name | `string` | n/a | yes |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | Github repo identifier for Workspace creation | `string` | n/a | yes |
| <a name="input_github_username"></a> [github\_username](#input\_github\_username) | Github Username | `string` | n/a | yes |
| <a name="input_k8s_service_account_name"></a> [k8s\_service\_account\_name](#input\_k8s\_service\_account\_name) | Kubernetes Service Account Name | `any` | n/a | yes |
| <a name="input_k8s_service_account_namespace"></a> [k8s\_service\_account\_namespace](#input\_k8s\_service\_account\_namespace) | Kubernetes Service Account Namespace | `any` | n/a | yes |
| <a name="input_kubernetes_workspace_directory"></a> [kubernetes\_workspace\_directory](#input\_kubernetes\_workspace\_directory) | Working directory for servers module | `string` | n/a | yes |
| <a name="input_kubernetes_workspace_name"></a> [kubernetes\_workspace\_name](#input\_kubernetes\_workspace\_name) | Kubernetes Workspace name | `string` | n/a | yes |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | Github OAuth Token ID | `any` | n/a | yes |
| <a name="input_servers_workspace_name"></a> [servers\_workspace\_name](#input\_servers\_workspace\_name) | Servers Workspace Name | `string` | n/a | yes |
| <a name="input_tfe_organization_name"></a> [tfe\_organization\_name](#input\_tfe\_organization\_name) | Terrafrom Cloud Organization Name | `string` | n/a | yes |
| <a name="input_vpc_workspace_name"></a> [vpc\_workspace\_name](#input\_vpc\_workspace\_name) | VPC Workspace name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubernetes_workspace_id"></a> [kubernetes\_workspace\_id](#output\_kubernetes\_workspace\_id) | Kubernetes Workspace ID |
<!-- END_TF_DOCS -->