output "node_role_name" {
  description = "the name of EKS Node Group IAM Role"
  value = aws_iam_role.nodes_role.name
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.cluster.name
}