output "consul_servers_private_ips" {
  description = "Private IP's of the Consul servers"
  value       = aws_instance.consul_servers.*.private_ip
}

output "jenkins_server_private_ip" {
  description = "Private IP of the Jenkins server"
  value       = aws_instance.jenkins_server.*.public_ip
}

output "jenkins_nodes_private_ip" {
  description = "Private IP's of the Jenkins nodes"
  value       = aws_instance.jenkins_nodes.*.private_ip
}

output "bastion_server_public_ip" {
  description = "Public IP of the Bastion host"
  value       = aws_isntace.bastion_server.*.public_ip
}

output "bastion_server_private_ip" {
  description = "Private IP of the Bastion host"
  value       = aws_isntace.bastion_server.*.private_ip
}

output "ansible_server_private_ip" {
  description = "Private IP of the Ansible server"
  value       = aws_isntace.ansible_server.*.private_ip
}

output "consul_alb_public_dns" {
  description = "Consul ALB Public DNS name"
  value       = aws_alb.consul_alb.dns_name
}

output "jenkins_alb_public_dns" {
  description = "Jenkins ALB Public DNS name"
  value       = aws_alb.jenkins_alb.dns_name
}
