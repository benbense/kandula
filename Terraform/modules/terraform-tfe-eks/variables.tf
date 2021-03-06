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
variable "kubernetes_workspace_name" {
  description = "Kubernetes Workspace name"
  type        = string
}
variable "vpc_workspace_name" {
  description = "VPC Workspace name"
  type        = string
}

variable "servers_workspace_name" {
  description = "Servers Workspace Name"
  type        = string
}
variable "github_repository_name" {
  description = "Github repo identifier for Workspace creation"
  type        = string
}

variable "kubernetes_workspace_directory" {
  description = "Working directory for servers module"
  type        = string
}

variable "auto_apply" {
  description = "Whether to automatically apply changes when a Terraform plan is successful"
}

variable "k8s_service_account_namespace" {
  description = "Kubernetes Service Account Namespace"
}

variable "k8s_service_account_name" {
  description = "Kubernetes Service Account Name"
}

variable "db_password" {
  type        = string
  description = "DB Password"
}
