aws_region = "es-east-1"
bucket_name = "terraform-state-bucket-123456"


# -------------------------------------------------------------------#
#   ---------------------------- Network -------------------------------#
# -------------------------------------------------------------------#


network_vpc_name = "${aws_region}-vpc"
network_vpc_cidr = "10.10.0.0/16"
network_public_subnets = {
  public_subnet_1 = {
    subnet_cidr = "10.10.1.0/24"
    subnet_az   = "es-east-1a"
  }
  public_subnet_2 = {
    subnet_cidr = "10.10.2.0/24"
    subnet_az   = "es-east-1b"
  }
  public_subnet_3 = {
    subnet_cidr = "10.10.3.0/24"
    subnet_az   = "es-east-1c"
  }
}
network_private_subnets = {
  private_subnet_1 = {
    subnet_cidr = "10.10.4.0/24"
    subnet_az   = "es-east-1a"
  }
  private_subnet_2 = {
    subnet_cidr = "10.10.5.0/24"
    subnet_az   = "es-east-1b"
  }
  private_subnet_3 = {
    subnet_cidr = "10.10.6.0/24"
    subnet_az   = "es-east-1c"
  }
}
