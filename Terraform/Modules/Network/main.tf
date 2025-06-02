#-------------------------------------------------------------------#
#----------------------------- VPC ---------------------------------#
#-------------------------------------------------------------------#

resource "aws_vpc" "VPC" {
  cidr_block = var.VPC_CIDR
  tags = {
    Name       = var.VPC_Name
    Deployment = "Terraform"
    "kubernetes.io/cluster/EKS_Cluster"="owned"
  }
}

#-------------------------------------------------------------------#
#----------------------------- Subnets -----------------------------#
#-------------------------------------------------------------------#

resource "aws_subnet" "Public_Subnets" {
  for_each = var.Public_Subnets

  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = each.value.Subnet_CIDR
  availability_zone       = each.value.Subnet_AZ
  map_public_ip_on_launch = true
  tags = {
    Name = each.key
    "kubernetes.io/cluster/EKS_Cluster"="owned"
    "kubernetes.io/role/elb"=1
  }
}

resource "aws_subnet" "Private_Subnets" {
  for_each = var.Private_Subnets

  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = each.value.Subnet_CIDR
  availability_zone       = each.value.Subnet_AZ
  map_public_ip_on_launch = false
  tags = {
    Name = each.key
    "kubernetes.io/cluster/EKS_Cluster"="owned"
    "kubernetes.io/role/internal-elb"=1
  }
}

#-------------------------------------------------------------------#
#---------------------------- Gateways -----------------------------#
#-------------------------------------------------------------------#

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name       = "Terraform IGW"
    Deployment = "Terraform"
  }
}

resource "aws_eip" "NatEIP" {
  domain = "vpc"
}
resource "aws_nat_gateway" "NatGW" {
  subnet_id     = values(aws_subnet.Public_Subnets)[0].id
  allocation_id = aws_eip.NatEIP.id
  tags = {
    Name       = "Terraform NAT"
    Deployment = "Terraform"
  }
  depends_on = [aws_internet_gateway.IGW]
}

#-------------------------------------------------------------------#
#------------------------------- RT --------------------------------#
#-------------------------------------------------------------------#

resource "aws_route_table" "PubRT" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name       = "PublicRT"
    Deployment = "Terraform"
  }
}

resource "aws_route_table" "PrivRT" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NatGW.id
  }
  tags = {
    Name       = "PrivateRT"
    Deployment = "Terraform"
  }
}

resource "aws_route_table_association" "Public_Association" {
  for_each       = aws_subnet.Public_Subnets
  subnet_id      = aws_subnet.Public_Subnets[each.key].id
  route_table_id = aws_route_table.PubRT.id
}

resource "aws_route_table_association" "Private_Association" {
  for_each       = aws_subnet.Private_Subnets
  subnet_id      = aws_subnet.Private_Subnets[each.key].id
  route_table_id = aws_route_table.PrivRT.id
}