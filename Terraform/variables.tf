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

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "bucket_name" {
  description = "Bucket name for ALB logs"
  type        = string
}

variable "servers_workspace_name" {
  description = "servers Workspace Name"
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

variable "servers_workspace_directory" {
  description = "Working directory for servers module"
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

variable "consul_servers_count" {
  type        = number
  description = "How much Consul servers to create"
  validation {
    condition     = var.consul_servers_count == 1 || var.consul_servers_count == 3 || var.consul_servers_count == 5
    error_message = "Invalid Consul servers amount, value must be 1 || 3 || 5."
  }
}

variable "jenkins_nodes_count" {
  type        = number
  description = "How much Jenkins nodes to create"
}

variable "private_key_path" {
  type        = string
  description = "File path to save the PEM key file"
}
