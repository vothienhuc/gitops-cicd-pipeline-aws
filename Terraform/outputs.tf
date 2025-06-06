output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.Network.VPC_ID
  
}

output "eks_oidc_provider_url" {
  description = "The URL of the OIDC provider"
  value       = module.OIDC.eks_oidc_provider_url
  
}