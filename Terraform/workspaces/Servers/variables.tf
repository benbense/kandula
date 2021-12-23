variable "instance_type" {
  type        = string
  description = "servers instances type"
}

variable "bucket_name" {
  type        = string
  description = "Bucket name for ALB logs"
}

variable "vpc_workspace_name" {
  type        = string
  description = "VPC Workspace Name for Backed State"
}

variable "organization_name" {
  type        = string
  description = "TFE Organization Name"
}

variable "servers_module_version" {
  type        = string
  description = "Servers module version to use"
}
variable "region" {
  type        = string
  description = "AWS region to deploy"
}
