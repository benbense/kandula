variable "tfe_organization_name" {
  description = "Terrafrom Cloud Organization Name"
  type        = string
}
variable "github_username" {
  description = "Github Username"
  type        = string
}
variable "oauth_token_id" {
  description = "Github OAuth Token ID"
}
variable "github_branch" {
  description = "Github Branch Name"
  type        = string
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
variable "rds_workspace_name" {
  description = "RDS Workspace name"
  type        = string
}
variable "vpc_workspace_name" {
  description = "VPC Workspace name"
  type        = string
}

variable "github_repository_name" {
  description = "Github repo identifier for Workspace creation"
  type        = string
}

variable "rds_workspace_directory" {
  description = "Working directory for servers module"
  type        = string
}

variable "auto_apply" {
  description = "Whether to automatically apply changes when a Terraform plan is successful"
}

variable "rds_ingress_ports" {
  type        = list(string)
  description = "Postgres RDS ingress ports"
}

variable "db_identifier_name" {
  type        = string
  description = "DB Identifier name"
}

variable "engine_version" {
  type        = string
  description = "DB Engine Version"
}
variable "instance_class" {
  type        = string
  description = "DB Instance class"
}
variable "db_username" {
  type        = string
  description = "DB Username"
}
