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

variable "tfe_organization_name" {
  type        = string
  description = "TFE Organization Name"
}

variable "jenkins_nodes_count" {
  description = "How much Jenkins nodes to create"
  type        = number
}

variable "consul_servers_count" {
  description = "How much Consul servers to create"
  type        = number
}

variable "server_key" {
  type        = string
  description = "Public SSH key name"
}
