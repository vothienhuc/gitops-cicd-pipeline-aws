variable "VPC_CIDR" {
  type = string
}

variable "VPC_Name" {
  type = string
}

variable "Public_Subnets" {
  type = map(object({
    Subnet_CIDR = string
    Subnet_AZ   = string
  }))
}

variable "Private_Subnets" {
  type = map(object({
    Subnet_CIDR = string
    Subnet_AZ   = string
  }))
}