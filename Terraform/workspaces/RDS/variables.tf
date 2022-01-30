variable "rds_ingress_ports" {
  type        = list(string)
  description = "Postgres RDS ingress ports"
  default     = [5432]
}

variable "vpc_workspace_name" {
  type        = string
  description = "VPC Workspace Name for Backed State"
}

variable "servers_workspace_name" {
  type        = string
  description = "Servers Workspace Name for Backed State"
}

variable "tfe_organization_name" {
  type        = string
  description = "TFE Organization Name"
}

variable "db_identifier_name" {
  type        = string
  description = "DB Identifier name"
  value       = "kanduladb"
}
