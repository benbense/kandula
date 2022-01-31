variable "rds_ingress_ports" {
  type        = list(string)
  description = "Postgres RDS ingress ports"
}

variable "db_identifier_name" {
  type        = string
  description = "DB Identifier name"
}

variable "engine_version" {
  type        = string
  description = "DB Engine Version"
}
variable "instance_class" {
  type        = string
  description = "DB Instance class"
}
variable "db_username" {
  type        = string
  description = "DB Username"
}
variable "vpc_workspace_name" {
  type        = string
  description = "VPC Workspace Name for Backed State"
}
variable "tfe_organization_name" {
  type        = string
  description = "TFE Organization Name"
}
