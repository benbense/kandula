<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.70.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | 0.27.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.70.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.27.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | .\modules\terraform-tfe-eks | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | .\modules\terraform-tfe-rds | n/a |
| <a name="module_servers"></a> [servers](#module\_servers) | .\modules\terraform-tfe-servers | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | .\modules\terraform-tfe-vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.server_key](https://registry.terraform.io/providers/hashicorp/aws/3.70.0/docs/resources/key_pair) | resource |
| [local_file.server_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tfe_notification_configuration.k8s_slack_notifications](https://registry.terraform.io/providers/hashicorp/tfe/0.27.0/docs/resources/notification_configuration) | resource |
| [tfe_notification_configuration.rds_slack_notifications](https://registry.terraform.io/providers/hashicorp/tfe/0.27.0/docs/resources/notification_configuration) | resource |
| [tfe_notification_configuration.servers_slack_notifications](https://registry.terraform.io/providers/hashicorp/tfe/0.27.0/docs/resources/notification_configuration) | resource |
| [tfe_notification_configuration.vpc_slack_notifications](https://registry.terraform.io/providers/hashicorp/tfe/0.27.0/docs/resources/notification_configuration) | resource |
| [tfe_oauth_client.github_oauth](https://registry.terraform.io/providers/hashicorp/tfe/0.27.0/docs/resources/oauth_client) | resource |
| [tfe_registry_module.aws-rds](https://registry.terraform.io/providers/hashicorp/tfe/0.27.0/docs/resources/registry_module) | resource |
| [tfe_registry_module.aws-servers](https://registry.terraform.io/providers/hashicorp/tfe/0.27.0/docs/resources/registry_module) | resource |
| [tfe_registry_module.aws-vpc](https://registry.terraform.io/providers/hashicorp/tfe/0.27.0/docs/resources/registry_module) | resource |
| [tls_private_key.server_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [template_file.cert_body](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.cert_private_key](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones to account for | `number` | `2` | no |
| <a name="input_aws_acess_key"></a> [aws\_acess\_key](#input\_aws\_acess\_key) | AWS Acess Key | `string` | n/a | yes |
| <a name="input_aws_default_region"></a> [aws\_default\_region](#input\_aws\_default\_region) | AWS Default Region | `string` | n/a | yes |
| <a name="input_aws_secret_acess_key"></a> [aws\_secret\_acess\_key](#input\_aws\_secret\_acess\_key) | AWS Secret Acess Key | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket name for ALB logs | `string` | `"kandula-bucket"` | no |
| <a name="input_cidr_size"></a> [cidr\_size](#input\_cidr\_size) | CIDR Size | `string` | `"10.0.0.0/16"` | no |
| <a name="input_consul_servers_count"></a> [consul\_servers\_count](#input\_consul\_servers\_count) | How much Consul servers to create | `number` | `3` | no |
| <a name="input_db_identifier_name"></a> [db\_identifier\_name](#input\_db\_identifier\_name) | DB Identifier name | `string` | `"kanduladb"` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | DB Username | `string` | `"postgres"` | no |
| <a name="input_elb_account_id"></a> [elb\_account\_id](#input\_elb\_account\_id) | ELB Account ID - pick one according to region https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | DB Engine Version | `string` | `"12.5"` | no |
| <a name="input_github_branch"></a> [github\_branch](#input\_github\_branch) | Github Branch Name | `string` | `"main"` | no |
| <a name="input_github_pat"></a> [github\_pat](#input\_github\_pat) | n/a | `string` | `"Github Personal Acess Token"` | no |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | Github repo identifier for Workspace creation | `string` | `"kandula"` | no |
| <a name="input_github_username"></a> [github\_username](#input\_github\_username) | Github Username | `string` | `"benbense"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | DB Instance class | `string` | `"db.t2.micro"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | `"t2.micro"` | no |
| <a name="input_jenkins_nodes_count"></a> [jenkins\_nodes\_count](#input\_jenkins\_nodes\_count) | How much Jenkins nodes to create | `number` | `2` | no |
| <a name="input_k8s_service_account_name"></a> [k8s\_service\_account\_name](#input\_k8s\_service\_account\_name) | Kubernetes Service Account Name | `string` | `"kandula-sa"` | no |
| <a name="input_k8s_service_account_namespace"></a> [k8s\_service\_account\_namespace](#input\_k8s\_service\_account\_namespace) | Kubernetes Service Account Namespace | `string` | `"default"` | no |
| <a name="input_kubernetes_workspace_directory"></a> [kubernetes\_workspace\_directory](#input\_kubernetes\_workspace\_directory) | Directory for servers module | `string` | `"Terraform/workspaces/K8s"` | no |
| <a name="input_kubernetes_workspace_name"></a> [kubernetes\_workspace\_name](#input\_kubernetes\_workspace\_name) | Kubernetes Workspace name | `string` | `"K8s-Workspace"` | no |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | File path to save the PEM key file | `string` | n/a | yes |
| <a name="input_rds_workspace_directory"></a> [rds\_workspace\_directory](#input\_rds\_workspace\_directory) | Directory for RDS module | `string` | `"Terraform/workspaces/RDS"` | no |
| <a name="input_rds_workspace_name"></a> [rds\_workspace\_name](#input\_rds\_workspace\_name) | RDS Workspace Name | `string` | `"RDS-Workspace"` | no |
| <a name="input_servers_workspace_directory"></a> [servers\_workspace\_directory](#input\_servers\_workspace\_directory) | Directory for servers module | `string` | `"Terraform/workspaces/Servers"` | no |
| <a name="input_servers_workspace_name"></a> [servers\_workspace\_name](#input\_servers\_workspace\_name) | servers Workspace Name | `string` | `"Servers-Workspace"` | no |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | Slack Webhook URL for Notifications | `string` | n/a | yes |
| <a name="input_tfe_organization_email"></a> [tfe\_organization\_email](#input\_tfe\_organization\_email) | Terraform Cloud Organization Admin Email Address | `string` | n/a | yes |
| <a name="input_tfe_organization_name"></a> [tfe\_organization\_name](#input\_tfe\_organization\_name) | Terrafrom Cloud Organization Name | `string` | n/a | yes |
| <a name="input_tfe_token"></a> [tfe\_token](#input\_tfe\_token) | Terraform Cloud API Token | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name | `string` | `"Kandula"` | no |
| <a name="input_vpc_workspace_directory"></a> [vpc\_workspace\_directory](#input\_vpc\_workspace\_directory) | Directory for vpc module | `string` | `"Terraform/workspaces/VPC"` | no |
| <a name="input_vpc_workspace_name"></a> [vpc\_workspace\_name](#input\_vpc\_workspace\_name) | VPC Workspace Name | `string` | `"VPC-Workspace"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->