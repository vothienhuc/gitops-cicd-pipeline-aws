✅ 1. Infrastructure Provisioning – With Terraform (Mandatory)
Provision the following using Terraform only:
● VPC with 3 public and 3 private subnets across 3 AZs
● NAT Gateway, Internet Gateway, Route Tables
● Amazon EKS Cluster
○ Control plane and node groups in private subnets


ECR---->  
DB-----> RDS, redis
secret Manager
``cert-manager`` Use cert-manager and Let's Encrypt for HTTPS
|-------------->ROUTE53
---------------------------------------

helm , ``Kustomize``

1- jenkins
2- Argocd
3- External Secrets Operator

------------------------------------------------------
● Set up MySQL and Redis as pods within the EKS
cluster

**DNS>> Deployment App
SErvice
(statefulset)mySql ----PV**

-----------------------------------------------

Deploy NGINX Ingress Controller or AWS Load Balancer Controller
● Use Ingress resources to expose the app securely
● Use cert-manager and Let's Encrypt for HTTPS



--------------------------------------------
Future Work 

- ROut53 with 53   

------------------------
2. CI Tool – Jenkins
● Install Jenkins via Helm into EKS
● Use a Jenkins pipelines to:
○ Clone NodeJs app repo
○ Build and push Docker images to Amazon ECR
○ Run your terraform code
--------------------------------------------------
🔐 4. Secrets Management – External Secrets Operator
[Bonus]
● Install external secrets operator via Helm
● Connect to AWS Secrets Manager
● Automatically sync secrets into Kubernetes Secrets:
○ Database and Redis credentials

----------------------------------------------------------

🐍 5. Application: NodeJS App with MySQL and Redis
● Deploy a NodeJS web application
(https://github.com/mahmoud254/jenkins_nodejs_example.git)
● Set up MySQL and Redis as pods within the EKS
cluster
● Connect to:
o The MySQL pod using environment variables for configuration
o The Redis pod for caching purposes
● Use Helm or Kustomize for Kubernetes manifests

----------------------


resource "aws_eks_cluster" "example" {
  name = "example"

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.az1.id,
      aws_subnet.az2.id,
      aws_subnet.az3.id,
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}



-------------------------------------














1- gg




















