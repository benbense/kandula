<p align="center"><img width="250px" src="KandulaLogo.png"></p>

<h1 align="center">Kandula</h1>

> An OpSchool Project for Cloud deployment.

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Terraform Deploying Instructions](#terraform-deploying-instructions)
- [Jenkins Deploying Instructions](#jenkins-deploying-instructions)
- [Variables References Table](#variables-references-table)
- [Mandatory](#mandatory)
- [Defaults](#defaults)


## Features

This deployment tool will deploy:
+ 3 Worksapces in Terraform Cloud
  + VPC Workspace
  + Servers Workspace
  + Kubernetes Cluster
+ Ansible Playbook
  + Install and configure Consul
  + Install 1 Jenkins server & 2 Jenkins nodes
+ Kubernetes Cluser
  + 2 Workers inside 2 different subnets


## Prerequisites 

In order to deploy the environemt a few prerequisites are mandatory, the deployment is based on the values that you put in the `vars.txt` file, for convenience you can use the [example](vars.example.txt) file.

You should fill in all of the required variables as referenced in the [Variables References Table](#variables-references-table).

- Terrafrom Cloud
  - [Create organization](https://www.terraform.io/cloud-docs/users-teams-organizations/organizations#creating-organizations)
  - [Create user API token](https://www.terraform.io/cloud-docs/users-teams-organizations/users#api-tokens)
- Terraform
  - Terraform should be [installed](https://learn.hashicorp.com/tutorials/terraform/install-cli) on the deployment station
- Python
  - Python 3
  - [Required modules](requirements.txt) Use `pip install -r requirements.txt` to install them.
- Slack
  - Slack Webhook URL

After all requirements mentioned above make sure your `vars.txt` file is filled up correctly.


## Terraform Deploying Instructions 

> Make sure all the variables in your newly created `vars.txt` file are correct before continuing!

- Run `python provisioner.py <path/of/vars.txt>`

## Jenkins Deploying Instructions 
- WIP

## Variables References Table

This table will help you determine whcih value should be in each variables inside the `vars.example.txt` file.

Notes: 
- The syntax shoule be `Key=Value`
- In case you are foking the repo, make sure `github_username` and `github_repository_name` are correct.

## Mandatory

| Variable               | Description                                                                                                                                                                           | Type |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---- |
| tfe_organization_name  | Terrafrom Cloud Organization Name                                                                                                                                                     | str  |
| aws_acess_key          | AWS Acess Key                                                                                                                                                                         | str  |
| aws_secret_acess_key   | AWS Secret Acess Key                                                                                                                                                                  | str  |
| tfe_token              | Terraform Cloud API Token                                                                                                                                                             | str  |
| github_pat             | Github Personal Acess Token                                                                                                                                                           | str  |
| slack_webhook_url      | Slack Webhook URL for Notifications                                                                                                                                                   | str  |
| private_key_path       | File path to save the PEM key file                                                                                                                                                    | str  |
| tfe_organization_email | Terraform Cloud Organization Admin Email Address                                                                                                                                      | str  |
| aws_default_region     | AWS Default Region                                                                                                                                                                    | str  |
| elb_account_id         | ELB Account ID - [Pick one according to region](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions) | int  |

## Defaults
> All of those values are pre-filled in the `Terraform/variables.tf` file but can be modified by the user.
> 
| Variable                       | Description                                                                | Type |
| ------------------------------ | -------------------------------------------------------------------------- | ---- |
| github_username                | Github Username                                                            | str  |
| github_branch                  | Github Branch Name                                                         | str  |
| availability_zones             | Availability zones to create                                               | int  |
| vpc_name                       | VPC Name                                                                   | str  |
| cidr_size                      | VPC CIDR Size                                                              | str  |
| bucket_name                    | Bucket name for ALB logs                                                   | str  |
| instance_type                  | EC2 Instance type                                                          | str  |
| servers_workspace_name         | Servers Workspace Name                                                     | str  |
| vpc_workspace_name             | VPC Workspace Name                                                         | str  |
| kubernetes_workspace_name      | Kubernetes Workspace Name                                                  | str  |
| github_repository_name         | Github repo identifier for Workspace creation                              | str  |
| servers_workspace_directory    | Working directory for servers module                                       | str  |
| vpc_workspace_directory        | Working directory for vpc module                                           | str  |
| kubernetes_workspace_directory | Working directory for Kubernetes module                                    | str  |
| k8s_service_account_namespace  | Kubernetes Service Account Namespace                                       | str  |
| k8s_service_account_name       | Kubernetes Service Account Name                                            | str  |
| auto_apply                     | Whether to automatically apply changes when a Terraform plan is successful | bool |
| consul_servers_count           | How much Consul servers to create (1, 3, 5)                                | int  |
| jenkins_nodes_count            | How much Jenkins nodes to create (Keep it on 2 only)                       | int  |
