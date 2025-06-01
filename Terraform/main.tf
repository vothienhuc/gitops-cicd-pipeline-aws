module "Network" {
  source = "/module/Network"
  vpc_name= var.network_vpc
  vpc_cidr = var.network_vpc_cidr
  public_subnets = var.network_public_subnets
  private_subnets = var.network_private_subnets
  }