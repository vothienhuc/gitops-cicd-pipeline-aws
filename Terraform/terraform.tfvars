
# -------------------------------------------------------------------#
#   ---------------------------- Network -------------------------------#
# -------------------------------------------------------------------#
aws_region = "us-east-1"
network_vpc_name = "us-east-1-vpc"
network_vpc_cidr = "10.10.0.0/16"
network_public_subnets = {
  public_subnet_1 = {
    Subnet_CIDR = "10.10.1.0/24"
    Subnet_AZ   = "us-east-1a"
  }
  public_subnet_2 = {
    Subnet_CIDR = "10.10.2.0/24"
    Subnet_AZ   = "us-east-1b"
  }
  public_subnet_3 = {
    Subnet_CIDR = "10.10.3.0/24"
    Subnet_AZ   = "us-east-1c"
  }
}
network_private_subnets = {
  private_subnet_1 = {
    Subnet_CIDR = "10.10.4.0/24"
    Subnet_AZ   = "us-east-1a"
  }
  private_subnet_2 = {
    Subnet_CIDR = "10.10.5.0/24"
    Subnet_AZ   = "us-east-1b"
  }
  private_subnet_3 = {
    Subnet_CIDR = "10.10.6.0/24"
    Subnet_AZ   = "us-east-1c"
  }
}

# -------------------------------------------------------------------#
# ---------------------------- EBS CSI Driver --------------------------# 
# ------------------------------------------------------------------------#
ebs_csi_driver_namespace = "kube-system"
ebs_csi_driver_service_account_name = "ebs-csi-controller-sa"