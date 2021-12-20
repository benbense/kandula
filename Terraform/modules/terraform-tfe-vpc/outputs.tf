output "vpc_workspace_id" {
  description = "VPC Workspace ID"
  value       = tfe_workspace.vpc.id
}
