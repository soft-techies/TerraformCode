
output "vpc_id" {
  value = aws_vpc.task_vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet_1.id
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet_2.id
}
output "private_subnet_a_id" {
  value = aws_subnet.private_subnet_1.id
}
output "private_subnet_b_id" {
  value = aws_subnet.private_subnet_2.id
}
output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.id
}
