output "VPC_ID" {
  value = aws_vpc.VPC.id
}

output "PubSubID" {
  value = {
    for key, subnet in aws_subnet.Public_Subnets :
    key => subnet.id
  }
}
output "PrivSubID" {
  value = {
    for key, subnet in aws_subnet.Private_Subnets :
    key => subnet.id
  }
}