output "vpc_id" {
  value = module.vpc.vpc_id
}

output "available_zone_names" {
  value = module.vpc.available_zone_names
}

output "public_subnets_ids" {
  value = module.vpc.public_subnets_ids
}

output "private_subnets_ids" {
  value = module.vpc.private_subnets_ids
}

output "instance_profile_name" {
  description = "IAM Policy name"
  value       = module.vpc.instance_profile_name
}

output "cluster_name" {
  description = "EKS Cluster name"
  value       = module.vpc.cluster_name
}
