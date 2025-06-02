output "node_role_name" {
  description = "the name of EKS Node Group IAM Role"
  value = aws_iam_role.nodes_role.name
}