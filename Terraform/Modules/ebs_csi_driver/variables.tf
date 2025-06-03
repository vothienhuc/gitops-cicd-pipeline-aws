variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC provider for the EKS cluster"
  type        = string
  
}
variable "oidc_provider_url" {
  description = "The URL of the OIDC provider for the EKS cluster"
  type        = string
  
}
variable "namespace" {
  description = "The Kubernetes namespace where the EBS CSI Driver will be deployed"
  type        = string
  default     = "kube-system"
}

variable "service_account_name" {
  description = "The name of the Kubernetes service account for the EBS CSI Driver"
  type        = string
  default     = "ebs-csi-controller-sa"
}
