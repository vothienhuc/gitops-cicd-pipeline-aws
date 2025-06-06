variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "region" {
  default = "us-east-1"
}

# variable "service_account_name" {
#   default = "jenkins-kaniko-sa"
# }

# variable "namespace" {
#   default = "jenkins"
# }