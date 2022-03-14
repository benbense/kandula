output "rds_endpoint" {
  description = "RDS Connection Endpoint"
  value       = module.rds.rds_endpoint
}

output "rds_address" {
  description = "RDS Host address"
  value       = module.rds.rds_address
}

output "rds_port" {
  description = "RDS Port"
  value       = module.rds.rds_port
}

output "db_password" {
  description = "RDS Password"
  value = module.rds.db_password
}