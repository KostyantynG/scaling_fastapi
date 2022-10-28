# Create vpc
resource "aws_vpc" "scaling_fastapi_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "Scaling Fastapi VPC"
  }
}

# Create public subnet in AZ a
resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.scaling_fastapi_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Public Subnet A"
  }
}

# Create public subnet in AZ b
resource "aws_subnet" "public_subnet_b" {
  vpc_id     = aws_vpc.scaling_fastapi_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Public Subnet B"
  }
}

# Create private subnet in AZ a
resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.scaling_fastapi_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Private Subnet A"
  }
}

# Create private subnet in AZ b
resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.scaling_fastapi_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Private Subnet B"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "scaling_fastapi_igw" {
  vpc_id = aws_vpc.scaling_fastapi_vpc.id

  tags = {
    Name = "Scaling Fastapi IGW"
  }
}

# Create public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.scaling_fastapi_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.scaling_fastapi_igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Create public route table association
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}