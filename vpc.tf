
resource "aws_vpc" "task_vpc" {
  cidr_block           = "10.200.0.0/16"

  tags = {
    Name = "task-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.task_vpc.id
  cidr_block = "10.200.1.0/24"
availability_zone       = var.az_a
  map_public_ip_on_launch = true
  tags = { Name = "public1" }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.task_vpc.id
  cidr_block = "10.200.2.0/24"
availability_zone       = var.az_b
  map_public_ip_on_launch = true
  tags = { Name = "public2" }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.task_vpc.id
  cidr_block = "10.200.3.0/24"
availability_zone = var.az_a
  tags = { Name = "private1" }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.task_vpc.id
  cidr_block = "10.200.4.0/24"
 availability_zone = var.az_b
  tags = { Name = "private2" }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.task_vpc.id

  tags = { Name = "igw" }
}
resource "aws_route_table" "public_route_table" {
   vpc_id = aws_vpc.task_vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id 
}
  tags = {
    Name = "public_rt"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = { Name = "nat-gw" }
}
resource "aws_route_table" "private_route_table" {
   vpc_id = aws_vpc.task_vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id 
}
  tags = {
    Name = "private_rt"
  }
}
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}


