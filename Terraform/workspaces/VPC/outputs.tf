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
