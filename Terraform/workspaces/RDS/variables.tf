variable "rds_ingress_ports" {
  type        = list(string)
  description = "Postgres RDS ingress ports"
  default     = [5432]
}

variable "private_subnets_ids" {
  description = "List of private subnets ids"
  type        = list(string)
}
