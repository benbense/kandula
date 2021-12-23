variable "vpc_name" {
  type        = string
  description = "VPC Name"
}
variable "region" {
  type        = string
  description = "AWS region to deploy"
}
variable "cidr_size" {
  type        = string
  description = "CIDR Size"
}

variable "availability_zones" {
  type        = number
  description = "Availability zones to account for"
}

variable "instances_to_create" {
  type        = number
  description = "servers instances to create"
}

variable "instance_type" {
  type        = string
  description = "servers instances type"
}

variable "bucket_name" {
  type        = string
  description = "Bucket name for ALB logs"
}

variable "servers_module_version" {
  type        = string
  description = "VPC module version to use"
}

variable "vpc_workspace_name" {
  type        = string
  description = "VPC Workspace Name for Backed State"
}

variable "organization_name" {
  type        = string
  description = "TFE Organization Name"
}

variable "aws_provider_version" {
  type        = string
  description = "AWS Provider version to use"
}
