variable "rds_ingress_ports" {
  type        = list(string)
  description = "Postgres RDS ingress ports"
  default     = [5432]
}
