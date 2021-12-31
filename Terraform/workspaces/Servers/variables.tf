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

variable "elb_account_id" {
  description = "ELB Account ID - pick one according to region https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions"
  type        = string
}
