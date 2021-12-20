variable "tfe_organization_name" {
  description = "Terrafrom Cloud Organization Name"
  type        = string
}
variable "github_user" {
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

variable "instances_to_create" {
  description = "Number of EC2 instances to create"
  type        = number
}
variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "bucket_name" {
  description = "Bucket name for ALB logs"
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
variable "ec2_workspace_name" {
  description = "EC2 Workspace name"
  type        = string
}
variable "vpc_workspace_name" {
  description = "VPC Workspace name"
  type        = string
}
variable "workspace_repo_identifier" {
  description = "Github repo identifier for Workspace creation"
  type        = string
}

variable "ec2_workspace_directory" {
  description = "Working directory for EC2 module"
  type        = string
}

variable "auto_apply" {
  description = "Whether to automatically apply changes when a Terraform plan is successful"
}
