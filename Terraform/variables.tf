
variable "aws_region" {
  type = string
  description = "AWS region to deploy resources"
}
variable "bucket_name" {
  type = string
  description = "Name of the S3 bucket for storing Terraform state"
  
}

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
    subnet_cidr = string
    subnet_az   = string
  }))
  description = "Map of public subnets with CIDR and availability zone"
}
variable "network_private_subnets" {
  type = map(object({
    subnet_cidr = string
    subnet_az   = string
  }))
  description = "Map of private subnets with CIDR and availability zone"
}


