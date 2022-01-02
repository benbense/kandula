<p align="center"><img width="300px" src="https://static.wixstatic.com/media/70129d_012e0994c5ad44979e261f8d59f9df5a~mv2.png/v1/fill/w_295,h_137,al_c,q_85,usm_0.66_1.00_0.01/Layer_1.webp" alt="RGBMaster"></p>

# Kandula 🐘
> An OpSchool Project for Cloud deployment.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Deploying Instructions](#deploying-instructions)
- [Variables References Table](#variables-references-table)


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

In order to deploy the environemt a few prerequisites are mandatory, the deployment is based on the values that you put in the `.tfvars` file.
You should fill in all of the required variables as referenced in the [Variables References Table](#variables-references-table).

On the deploying station the only prerequisite is Python 3 and the pip packages mentioned insite the `requirements.txt` file.

Use `pip install -r requirements.txt` to install them.



## Deploying Instructions 

Make sure all the variables in the `.tfvars.` file are correct before continuing!

- Place the `.tfvars` file inside the `Terraform` folder.
- Run `python provisioner.py Terraform\<tfvars-file>`
- You should see the Python script starting up


## Variables References Table

This table will help you determine whcih value should be in each variables inside the `.tfvars` file.

> Note: The syntax shoule be `Key=Value`

| Variable | Description |
| ------ | ------ |
| tfe_organization_name | Terrafrom Cloud Organization Name |
| github_user | Github Username |
| github_branch | Github Branch Name |
| availability_zones | Availability zones to account for |
| vpc_name | VPC Name |
| aws_acess_key | AWS Acess Key |
| aws_secret_acess_key | AWS Secret Acess Key |
| aws_default_region | AWS Default Region |
| cidr_size | VPC CIDR Size |
| tfe_token | Terraform Cloud API Token |
| github_pat | Github Personal Acess Token |
| bucket_name | Bucket name for ALB logs |
| instance_type | EC2 Instance type |
| servers_workspace_name | Servers Workspace Name |
| vpc_workspace_name | VPC Workspace Name |
| kubernetes_workspace_name | Kubernetes Workspace Name |
| slack_webhook_url | Slack Webhook URL for Notifications |
| tfe_organization_email | Terraform Cloud Organization Admin Email Address |
| workspace_repo_identifier | Github repo identifier for Workspace creation |
| servers_workspace_directory | Working directory for servers module |
| vpc_workspace_directory | Working directory for vpc module |
| kubernetes_workspace_directory | Working directory for Kubernetes module |
| k8s_service_account_namespace | Kubernetes Service Account Namespace |
| k8s_service_account_name | Kubernetes Service Account Name |
| elb_account_id | ELB Account ID - [Pick one according to region](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions) |
| auto_apply | Whether to automatically apply changes when a Terraform plan is successful |
| consul_servers_count | How much Consul servers to create (1, 3, 5) |
| jenkins_nodes_count | How much Jenkins nodes to create (Keep it on 2 only) |
| private_key_path | File path to save the PEM key file |