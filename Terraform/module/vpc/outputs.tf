
output "vpc_id" {
  description = "VPC ID of newly created VPC"
  value       = aws_vpc.ctpvpc.id
}



# Prviate subnet 1, 2
output "pri_subnet_a" {
  description = "private subnet a ID in VPC"
  value       = aws_subnet.private_subnet_a.id
}

output "pri_subnet_c" {
  description = "private subnet c ID in VPC"
  value       = aws_subnet.private_subnet_c.id
}

# Public subnets
output "pub_subnet_a" {
  description = "public subnet a ID in VPC"
  value       = aws_subnet.public_subnet_a.id
}

output "pub_subnet_c" {
  description = "public subnet c ID in VPC"
  value       = aws_subnet.public_subnet_c.id
}


# Route tables

output "pub_RT" {
  description = "public route table ID in VPC"
  value       = aws_route_table.route_table.id
}

output "pri_RT1" {
  description = "public route table ID in VPC"
  value       = aws_route_table.route_table_private_1.id
}

output "pri_RT2" {
  description = "public route table ID in VPC"
  value       = aws_route_table.route_table_private_2.id
}