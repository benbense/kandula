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
| [tfe_variable.aws_secret_acess_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.bucket_name](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.consul_servers_count](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.elb_account_id](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.instance_type](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.jenkins_nodes_count](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.server_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfe_organization_name](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.vpc_workspace_name](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.servers](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Whether to automatically apply changes when a Terraform plan is successful | `any` | n/a | yes |
| <a name="input_aws_acess_key"></a> [aws\_acess\_key](#input\_aws\_acess\_key) | AWS Acess Key | `string` | n/a | yes |
| <a name="input_aws_default_region"></a> [aws\_default\_region](#input\_aws\_default\_region) | AWS Default Region | `string` | n/a | yes |
| <a name="input_aws_secret_acess_key"></a> [aws\_secret\_acess\_key](#input\_aws\_secret\_acess\_key) | AWS Secret Acess Key | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket name for ALB logs | `string` | n/a | yes |
| <a name="input_consul_servers_count"></a> [consul\_servers\_count](#input\_consul\_servers\_count) | How much Consul servers to create | `any` | n/a | yes |
| <a name="input_elb_account_id"></a> [elb\_account\_id](#input\_elb\_account\_id) | ELB Account ID - pick one according to region https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions | `string` | n/a | yes |
| <a name="input_github_branch"></a> [github\_branch](#input\_github\_branch) | Github Branch Name | `string` | n/a | yes |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | Github repo identifier for Workspace creation | `string` | n/a | yes |
| <a name="input_github_username"></a> [github\_username](#input\_github\_username) | Github Username | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | n/a | yes |
| <a name="input_jenkins_nodes_count"></a> [jenkins\_nodes\_count](#input\_jenkins\_nodes\_count) | How much Jenkins nodes to create | `any` | n/a | yes |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | Github OAuth Token ID | `any` | n/a | yes |
| <a name="input_server_key"></a> [server\_key](#input\_server\_key) | Public SSH key name | `string` | n/a | yes |
| <a name="input_servers_workspace_directory"></a> [servers\_workspace\_directory](#input\_servers\_workspace\_directory) | Working directory for servers module | `string` | n/a | yes |
| <a name="input_servers_workspace_name"></a> [servers\_workspace\_name](#input\_servers\_workspace\_name) | servers Workspace name | `string` | n/a | yes |
| <a name="input_tfe_organization_name"></a> [tfe\_organization\_name](#input\_tfe\_organization\_name) | Terrafrom Cloud Organization Name | `string` | n/a | yes |
| <a name="input_vpc_workspace_name"></a> [vpc\_workspace\_name](#input\_vpc\_workspace\_name) | VPC Workspace name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_servers_workspace_id"></a> [servers\_workspace\_id](#output\_servers\_workspace\_id) | servers Workspace ID |
<!-- END_TF_DOCS -->