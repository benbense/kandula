<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_servers"></a> [servers](#module\_servers) | app.terraform.io/kandula/servers/aws | 1.0.19 |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket name for ALB logs | `string` | n/a | yes |
| <a name="input_consul_servers_count"></a> [consul\_servers\_count](#input\_consul\_servers\_count) | How much Consul servers to create | `number` | n/a | yes |
| <a name="input_elb_account_id"></a> [elb\_account\_id](#input\_elb\_account\_id) | ELB Account ID - pick one according to region https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | servers instances type | `string` | n/a | yes |
| <a name="input_jenkins_nodes_count"></a> [jenkins\_nodes\_count](#input\_jenkins\_nodes\_count) | How much Jenkins nodes to create | `number` | n/a | yes |
| <a name="input_server_key"></a> [server\_key](#input\_server\_key) | Public SSH key name | `string` | n/a | yes |
| <a name="input_tfe_organization_name"></a> [tfe\_organization\_name](#input\_tfe\_organization\_name) | TFE Organization Name | `string` | n/a | yes |
| <a name="input_vpc_workspace_name"></a> [vpc\_workspace\_name](#input\_vpc\_workspace\_name) | VPC Workspace Name for Backed State | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ansible_server_private_ip"></a> [ansible\_server\_private\_ip](#output\_ansible\_server\_private\_ip) | Private IP of the Ansible server |
| <a name="output_bastion_server_private_ip"></a> [bastion\_server\_private\_ip](#output\_bastion\_server\_private\_ip) | Private IP of the Bastion host |
| <a name="output_bastion_server_public_ip"></a> [bastion\_server\_public\_ip](#output\_bastion\_server\_public\_ip) | Public IP of the Bastion host |
| <a name="output_consul_alb_public_dns"></a> [consul\_alb\_public\_dns](#output\_consul\_alb\_public\_dns) | Consul ALB Public DNS name |
| <a name="output_consul_servers_private_ips"></a> [consul\_servers\_private\_ips](#output\_consul\_servers\_private\_ips) | Private IP's of the Consul servers |
| <a name="output_grafana_alb_public_dns"></a> [grafana\_alb\_public\_dns](#output\_grafana\_alb\_public\_dns) | Grafana ALB Public DNS name |
| <a name="output_jenkins_alb_public_dns"></a> [jenkins\_alb\_public\_dns](#output\_jenkins\_alb\_public\_dns) | Jenkins ALB Public DNS name |
| <a name="output_jenkins_nodes_arns"></a> [jenkins\_nodes\_arns](#output\_jenkins\_nodes\_arns) | ARN of the Jenkins Nodes Instances |
| <a name="output_jenkins_nodes_ids"></a> [jenkins\_nodes\_ids](#output\_jenkins\_nodes\_ids) | ID of the Jenkins Nodes Instances |
| <a name="output_jenkins_nodes_private_ip"></a> [jenkins\_nodes\_private\_ip](#output\_jenkins\_nodes\_private\_ip) | Private IP's of the Jenkins nodes |
| <a name="output_jenkins_server_private_ip"></a> [jenkins\_server\_private\_ip](#output\_jenkins\_server\_private\_ip) | Private IP of the Jenkins server |
| <a name="output_prometheus_alb_public_dns"></a> [prometheus\_alb\_public\_dns](#output\_prometheus\_alb\_public\_dns) | Prometheus ALB Public DNS name |
<!-- END_TF_DOCS -->