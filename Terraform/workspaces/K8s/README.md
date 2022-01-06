## Start EKS cluster with Terraform
This will start an EKS cluster with terraform

## Prerequisites
- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your workstation/server
- Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) on your workstation/server
- Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) on your workstation/server


## Variables
- Change the `aws_region` to your requested region (default: `us-east-1`)
- Change `kubernetes_version` to the desired version (default: `1.18`)
- Change `k8s_service_account_namespace` to the namespace for your application (default: `default`)
- Change `k8s_service_account_name` to the service account name for your application (default: `k8s_service_account_name`)

## Run
Run the following to start your eks environment:
```bash
terraform init
terraform apply --auto-approve
```

After the environement is up run the following to update your kubeconfig file (you can get the `cluster_name` value from the cluster_name output in terraform)
```bash
aws eks --region=us-east-1 update-kubeconfig --name <cluster_name>
```

To test the environemet run the following:
``` bash
kubectl get nodes -o wide
```

### Optional
If you'd like to add more authrized users or roles to your eks cluster follow this:
1. Create an IAM role or user that is authorized to user EKS

2. From an authorized user edit [`aws-auth-cm.yaml`](aws-auth-cm.yaml) update aws-auth configmap and add the relevant users/roles and execute with kubectl
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: <Replace with ARN of your EKS nodes role>
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
    - rolearn: arn:aws:iam::111122223333:role/eks_role 
      username: eks_role
      groups: 
        - system:masters
  mapUsers: |
    - userarn: <arn:aws:iam::111122223333:user/admin>
      username: <admin>
      groups:
        - <system:masters>
```
> **Important:** Make sure you get the nodes role arn from the currently configured configmap using `kubectl get configmap aws-auth -n kube-system  -o yaml` and replace with the above `<Replace with ARN of your EKS nodes role>`

3. If you're running with AWS cli you can verify your identity with the following:
```bash
aws sts get-caller-identity
``` 

## Read more...
- [EKS Terraform Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)
- [AWS VPC Terraform Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- [Getting started with EKS](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html)
- [AWS IAM Module](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest)
- [Managing users or IAM roles for your cluster](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)
- [EKS IRSA](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html)
