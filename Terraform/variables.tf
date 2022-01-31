variable "tfe_organization_name" {
  description = "Terrafrom Cloud Organization Name"
  type        = string
}
variable "tfe_token" {
  description = "Terraform Cloud API Token"
  type        = string
}
variable "github_username" {
  description = "Github Username"
  type        = string
  default     = "benbense"
}
variable "github_branch" {
  description = "Github Branch Name"
  type        = string
  default     = "main"
}

variable "availability_zones" {
  description = "Availability zones to account for"
  type        = number
  default     = 2
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "Kandula"
}

variable "aws_acess_key" {
  description = "AWS Acess Key"
  type        = string
}

variable "aws_secret_acess_key" {
  description = "AWS Secret Acess Key"
  type        = string
}
variable "aws_default_region" {
  description = "AWS Default Region"
  type        = string
}
variable "github_pat" {
  default = "Github Personal Acess Token"
  type    = string
}
variable "cidr_size" {
  description = "CIDR Size"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "bucket_name" {
  description = "Bucket name for ALB logs"
  type        = string
  default     = "kandula-bucket"
}

variable "servers_workspace_name" {
  description = "servers Workspace Name"
  type        = string
  default     = "Servers-Workspace"
}
variable "vpc_workspace_name" {
  description = "VPC Workspace Name"
  type        = string
  default     = "VPC-Workspace"
}

variable "slack_webhook_url" {
  description = "Slack Webhook URL for Notifications"
  type        = string
}

variable "tfe_organization_email" {
  description = "Terraform Cloud Organization Admin Email Address"
  type        = string
}

variable "github_repository_name" {
  description = "Github repo identifier for Workspace creation"
  type        = string
  default     = "kandula"
}

variable "servers_workspace_directory" {
  description = "Directory for servers module"
  type        = string
  default     = "Terraform/workspaces/Servers"
}

variable "vpc_workspace_directory" {
  description = "Directory for vpc module"
  type        = string
  default     = "Terraform/workspaces/VPC"
}

variable "auto_apply" {
  description = "Whether to automatically apply changes when a Terraform plan is successful"
  type        = bool
  default     = false
}

variable "consul_servers_count" {
  type        = number
  description = "How much Consul servers to create"
  default     = 3
}

variable "jenkins_nodes_count" {
  type        = number
  description = "How much Jenkins nodes to create"
  default     = 2
}

variable "private_key_path" {
  type        = string
  description = "File path to save the PEM key file"
}


variable "k8s_service_account_namespace" {
  type        = string
  description = "Kubernetes Service Account Namespace"
  default     = "default"
}

variable "k8s_service_account_name" {
  type        = string
  description = "Kubernetes Service Account Name"
  default     = "kandula-sa"
}

variable "kubernetes_workspace_directory" {
  description = "Directory for servers module"
  type        = string
  default     = "Terraform/workspaces/K8s"
}

variable "kubernetes_workspace_name" {
  description = "Kubernetes Workspace name"
  type        = string
  default     = "K8s-Workspace"
}

variable "elb_account_id" {
  description = "ELB Account ID - pick one according to region https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions"
  type        = string
}

variable "rds_workspace_name" {
  description = "RDS Workspace Name"
  type        = string
  default     = "RDS-Workspace"
}

variable "rds_workspace_directory" {
  description = "Directory for RDS module"
  type        = string
  default     = "Terraform/workspaces/RDS"
}

variable "rds_ingress_ports" {
  type        = list(string)
  description = "Postgres RDS ingress ports"
  default     = [5432]
}

variable "db_identifier_name" {
  type        = string
  description = "DB Identifier name"
  default     = "kanduladb"
}

variable "engine_version" {
  type        = string
  description = "DB Engine Version"
  default     = "12.5"
}
variable "instance_class" {
  type        = string
  description = "DB Instance class"
  default     = "db.t2.micro"
}
variable "db_username" {
  type        = string
  description = "DB Username"
  default     = "postgres"
}
