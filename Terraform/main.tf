module "Network" {
  source          = "./Modules/Network"
  VPC_Name        = var.network_vpc_name
  VPC_CIDR        = var.network_vpc_cidr
  Public_Subnets  = var.network_public_subnets
  Private_Subnets = var.network_private_subnets
}


module "EKS_Cluster" {
  source          = "./Modules/eks"
  eks_subnets_ids = values(module.Network.PrivSubID)

}

module "ECR" {
  source             = "./Modules/ecr"
  eks_node_role_name = module.EKS_Cluster.node_role_name
}

module "Secrets" {
  source         = "./Modules/secretManager"
  mySQL_username = var.mySQL_username
  mySQL_password = var.mySQL_password

}

module "EBS_CSI_Driver" {
  source                = "./Modules/ebs_csi_driver"
  eks_cluster_name      = module.EKS_Cluster.cluster_name
  oidc_provider_arn     = module.OIDC.oidc_provider_arn
  oidc_provider_url     = module.OIDC.oidc_provider_url
  namespace             = var.ebs_csi_driver_namespace
  service_account_name  = var.ebs_csi_driver_service_account_name
  
}

module "OIDC" {
  source           = "./Modules/oidc"
  eks_cluster_name = module.EKS_Cluster.cluster_name
  depends_on       = [module.EKS_Cluster]
}
