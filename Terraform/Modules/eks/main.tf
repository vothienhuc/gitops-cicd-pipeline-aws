#-------------------------------------------------------------------#
#----------------------------- Cluster------------------------------#
#-------------------------------------------------------------------#

resource "aws_eks_cluster" "cluster" {
    name = "eks-cluster"
    
    access_config {
        authentication_mode = "API"
    }

    role_arn = aws_iam_role.cluster_role.arn
    version = "1.31"

    vpc_config {
        subnet_ids = var.eks_subnets_ids
    }
    tags = {
        Name = "EKS Cluster"
        Environment = "Deployement"
    }
    depends_on = [aws_iam_role_policy_attachment.cluster_AmzonEKSClusterPolicy]
}

resource "aws_iam_role" "cluster_role" {
    name = "eks-cluster-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Action = [
                    "sts:AssumeRole",
                    "sts:TagSession"
                ]
                Effect = "Allow",
                Principal = {
                    Service = "eks.amazonaws.com"
                },
            }
        ]
    })

    tags = {
      tag-key = "eks_cluster-role"
    }
}

resource "aws_iam_policy_attachment" "cluster_AmzonEKSClusterPolicy" {
    name       = "eks-cluster-policy-attachment"
    roles      = [aws_iam_role.cluster_role.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  
}

#-------------------------------------------------------------------#
#----------------------------- Node-Group --------------------------#
#-------------------------------------------------------------------#

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.nodes_role.arn
  subnet_ids      = var.eks_subnets_ids

  instance_types = ["t3.medium"]
  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  /*remote_access {
    ec2_ssh_key = "eks-keypair" # Ensure this key pair exists in your AWS account
    source_security_group_ids = [aws_security_group.eks_node_group_sg.id]
  }*/

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
  tags = {
    Name = "EKS Node Group"
    Environment = "Deployment"
  }
  depends_on = [
    aws_iam_role_policy_attachment.node_group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group-AmazonEC2ContainerRegistryReadOnly,
  ]
  
}
resource "aws_iam_role" "nodes_role" {
    name = "eks-nodes-role"
    assume_role_policy = jsondecode({
        Version = "2012-10-17",
        Statement = [
            {
                Action = [
                    "sts:AssumeRole",
                    "sts:TagSession"
                ]
                Effect = "Allow",
                Principal = {
                    Service = "eks.amazonaws.com"
                },
            }
        ]
    })
  
}

resource "aws_iam_policy_attachment" "node_group-AmazonEKSWorkerNodePolicy" {
    name       = "eks-node-group-worker-policy-attachment"
    roles      = [aws_iam_role.nodes_role.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  
}
resource "aws_iam_policy_attachment" "node_group-AmazonEKS_CNI_Policy" {
    name       = "eks-node-group-cni-policy-attachment"
    roles      = [aws_iam_role.nodes_role.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  
}
resource "aws_iam_policy_attachment" "node_group-AmazonEC2ContainerRegistryReadOnly" {
    name       = "eks-node-group-ecr-readonly-policy-attachment"
    roles      = [aws_iam_role.nodes_role.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  
}