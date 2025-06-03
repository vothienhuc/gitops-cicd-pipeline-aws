variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "oidc_provider_url" {
  description = "EKS OIDC Provider URL (without https://)"
  type        = string
}