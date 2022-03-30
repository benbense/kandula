output "consul_servers_private_ips" {
  description = "Private IP's of the Consul servers"
  value       = module.servers.consul_servers_private_ips
}

output "jenkins_server_private_ip" {
  description = "Private IP of the Jenkins server"
  value       = module.servers.jenkins_server_private_ip
}

output "jenkins_nodes_private_ip" {
  description = "Private IP's of the Jenkins nodes"
  value       = module.servers.jenkins_nodes_private_ip
}

output "bastion_server_public_ip" {
  description = "Public IP of the Bastion host"
  value       = module.servers.bastion_server_public_ip
}

output "bastion_server_private_ip" {
  description = "Private IP of the Bastion host"
  value       = module.servers.bastion_server_private_ip
}

output "ansible_server_private_ip" {
  description = "Private IP of the Ansible server"
  value       = module.servers.ansible_server_private_ip
}

output "consul_alb_public_dns" {
  description = "Consul ALB Public DNS name"
  value       = module.servers.consul_alb_public_dns
}

output "jenkins_alb_public_dns" {
  description = "Jenkins ALB Public DNS name"
  value       = module.servers.jenkins_alb_public_dns
}

output "jenkins_nodes_arns" {
  description = "ARN of the Jenkins Nodes Instances"
  value       = module.servers.jenkins_nodes_arns
}

output "jenkins_nodes_ids" {
  description = "ID of the Jenkins Nodes Instances"
  value       = module.servers.jenkins_nodes_ids
}

output "grafana_alb_public_dns" {
  description = "Grafana ALB Public DNS name"
  value       = module.servers.grafana_alb_public_dns
}

output "prometheus_alb_public_dns" {
  description = "Prometheus ALB Public DNS name"
  value       = module.servers.prometheus_alb_public_dns
}

output "elk_server_private_ip" {
  description = "Private IP of the ELK server"
  value       = module.servers.elk_server_private_ip
}
