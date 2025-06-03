output "oidc_provider_url" {
  value       = replace(data.aws_eks_cluster.eks.identity[0].oidc[0].issuer, "https://", "")
  description = "EKS OIDC Provider URL (without https://)"
}
