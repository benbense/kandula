variable "kubernetes_version" {
  default     = 1.21
  description = "kubernetes version"
}

variable "aws_region" {
  default     = "us-east-1"
  description = "aws region"
}

variable "k8s_service_account_namespace" {
  description = "Kubernetes Service Account Namespace"
}

variable "k8s_service_account_name" {
  description = "Kubernetes Service Account Name"
}

variable "tfe_organization_name" {
  type        = string
  description = "TFE Organization Name"
}

variable "vpc_workspace_name" {
  type        = string
  description = "VPC Workspace Name for Backed State"
}

variable "servers_workspace_name" {
  type        = string
  description = "Servers Workspace Name for Backed State"
}
