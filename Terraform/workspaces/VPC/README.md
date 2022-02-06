<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.70.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | app.terraform.io/kandula/vpc/aws | 1.0.7 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones to account for | `number` | n/a | yes |
| <a name="input_cert_body"></a> [cert\_body](#input\_cert\_body) | SSL Certificate Body | `string` | n/a | yes |
| <a name="input_cert_private_key"></a> [cert\_private\_key](#input\_cert\_private\_key) | SSL Certificate PK | `string` | n/a | yes |
| <a name="input_cidr_size"></a> [cidr\_size](#input\_cidr\_size) | CIDR Size | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_available_zone_names"></a> [available\_zone\_names](#output\_available\_zone\_names) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | EKS Cluster name |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN Of Describe Instances Role |
| <a name="output_instance_profile_name"></a> [instance\_profile\_name](#output\_instance\_profile\_name) | IAM Policy name |
| <a name="output_kandula_ssl_cert"></a> [kandula\_ssl\_cert](#output\_kandula\_ssl\_cert) | ARN of SSL Certificate |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | n/a |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->