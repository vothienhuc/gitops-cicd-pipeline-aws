# -------------------------------------------------------------------#
# ---------------------------- Network -------------------------------#
# -------------------------------------------------------------------# 

variable "network_vpc_name" {
  type        = string
  description = "value of vpc name"
}

variable "network_vpc_cidr" {
  type        = string
  description = "value of vpc cidr"

}

variable "network_public_subnets" {
  type = map(object({
    Subnet_CIDR = string
    Subnet_AZ   = string
  }))
  description = "Map of public subnets with CIDR and availability zone"
}
variable "network_private_subnets" {
  type = map(object({
    Subnet_CIDR = string
    Subnet_AZ   = string
  }))
  description = "Map of private subnets with CIDR and availability zone"
}

variable "aws_region" {
  type        = string
  description = "AWS region where the resources will be created"
}


# -------------------------------------------------------------------#
# ---------------------------- Secret manager--------------------------#
# -------------------------------------------------------------------# 
variable "mySQL_username" {
  type      = string
  sensitive = true
}
variable "mySQL_password" {
  type      = string
  sensitive = true
}

# -------------------------------------------------------------------#
# ---------------------------- EBS CSI Driver --------------------------#
# -------------------------------------------------------------------#
variable "ebs_csi_driver_namespace" {
  type        = string
  description = "The Kubernetes namespace where the EBS CSI Driver will be deployed"
  default     = "kube-system"
}

variable "ebs_csi_driver_service_account_name" {
  type        = string
  description = "The name of the Kubernetes service account for the EBS CSI Driver"
  default     = "ebs-csi-controller-sa"
}
