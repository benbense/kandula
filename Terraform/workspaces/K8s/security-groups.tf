
resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

resource "aws_security_group" "prometheus_sg_k8s" {
  name        = "prometheus_sg_k8s"
  description = "Security group for Prometheus"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port = 9090
    to_port   = 9090
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

resource "aws_security_group" "consul_sg_k8s" {
  name        = "consul_sg_k8s"
  description = "Security group for Consul"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = [8600, 8301, 8302]
    content {
      from_port = port.value
      to_port   = port.value
      protocol  = "tcp"
      cidr_blocks = [
        "10.0.0.0/8",
        "172.16.0.0/12",
      "192.168.0.0/16", ]
    }
  }
  dynamic "ingress" {
    iterator = port
    for_each = [8600, 8301, 8302]
    content {
      from_port = port.value
      to_port   = port.value
      protocol  = "udp"
      cidr_blocks = [
        "10.0.0.0/8",
        "172.16.0.0/12",
      "192.168.0.0/16", ]
    }
  }
}

