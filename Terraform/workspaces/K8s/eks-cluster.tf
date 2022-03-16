data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "${var.tfe_organization_name}"
    workspaces = {
      name = "${var.vpc_workspace_name}"
    }
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = data.terraform_remote_state.vpc.outputs.cluster_name
  cluster_version = var.kubernetes_version
  subnets         = data.terraform_remote_state.vpc.outputs.private_subnets_ids

  enable_irsa = true

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t3.medium"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.all_worker_mgmt.id, aws_security_group.prometheus_sg_k8s.id, aws_security_group.consul_sg_k8s.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t3.large"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.all_worker_mgmt.id, aws_security_group.prometheus_sg_k8s.id, aws_security_group.consul_sg_k8s.id]
    }
  ]
  map_roles = [
    {
      rolearn  = data.terraform_remote_state.vpc.outputs.iam_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:masters"]
    }
  ]
  manage_aws_auth = true
}
data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

resource "kubernetes_secret" "aws_creds" {
  metadata {
    name = "aws-cred"
  }

  data = {
    username    = var.AWS_ACCESS_KEY_ID
    password    = var.AWS_SECRET_ACCESS_KEY
    db_password = var.db_password
  }

  type = "Opaque"
}
