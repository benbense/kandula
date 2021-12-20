variable "tfe_organization_name" {
  description = "Terrafrom Cloud Organization Name"
  type        = string
}
variable "tfe_token" {
  description = "Terraform Cloud API Token"
  type        = string
}
variable "github_user" {
  description = "Github Username"
  type        = string
}
variable "github_branch" {
  description = "Github Branch Name"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones to account for"
  type        = number
}

variable "vpc_name" {
  description = "VPC Name"
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
variable "github_pat" {
  default = "Github Personal Acess Token"
  type    = string
}
variable "cidr_size" {
  description = "CIDR Size"
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

variable "ec2_workspace_name" {
  description = "EC2 Workspace Name"
  type        = string
}
variable "vpc_workspace_name" {
  description = "VPC Workspace Name"
  type        = string
}

variable "slack_webhook_url" {
  description = "Slack Webhook URL for Notifications"
  type        = string
}

variable "tfe_organization_email" {
  description = "Terraform Cloud Organization Admin Email Address"
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

variable "vpc_workspace_directory" {
  description = "Working directory for vpc module"
  type        = string
}

variable "auto_apply" {
  description = "Whether to automatically apply changes when a Terraform plan is successful"
  type        = bool
}

