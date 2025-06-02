# -------------------------------------------------------------------#
# ---------------------------- Network -------------------------------#
# -------------------------------------------------------------------# 

variable "network_vpc_name" {
  type = string
  description = "value of vpc name" 
}

variable "network_vpc_cidr" {
  type = string
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
  type = string
  description = "AWS region where the resources will be created"
}