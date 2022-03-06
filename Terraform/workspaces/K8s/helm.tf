resource "kubernetes_secret" "consul_secrets" {
  metadata {
    name = "${module.eks.cluster_id}-hcp"
  }

  data = {
    gossipEncryptionKey = "uDBV4e+LbFW3019YKPxIrg=="
  }

  type = "Opaque"
}

resource "helm_release" "consul" {
  name       = "consul"
  repository = "https://helm.releases.hashicorp.com"
  version    = var.consul_chart_version
  chart      = "consul"

  values = [
    templatefile("${path.module}/consul.tpl", {
      datacenter       = "kandula"
      consul_hosts     = jsonencode(var.consul_hosts)
      cluster_id       = module.eks.cluster_id
      k8s_api_endpoint = module.eks.cluster_endpoint
      consul_version   = substr(var.consul_version, 1, -1)
    })
  ]

  # Helm installation relies on the Kuberenetes secret being
  # available.
  depends_on = [kubernetes_secret.consul_secrets]
}

variable "consul_hosts" {
  default = "provider=aws tag_key=service_role tag_value=service_discovery region=us-east-1"
}
variable "consul_version" {
  type = string
  default = "1.11.1"
}
variable "chart_version" {
  type        = string
  description = "The Consul Helm chart version to use"
  default     = "0.33.0"
}