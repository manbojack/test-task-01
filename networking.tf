#------------------------------------------------------------------------------
# VPC:
#------------------------------------------------------------------------------
resource "aws_vpc" "test_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = {
    Name = "test_vpc"
  }
}

#------------------------------------------------------------------------------
# Public Subnet:
#------------------------------------------------------------------------------
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.REGION}-a"
  map_public_ip_on_launch = true
  tags                    = {
    Name = "Test Public Subnet"
  }
}

#------------------------------------------------------------------------------
# Private Subnet:
#------------------------------------------------------------------------------
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.REGION}-b"
  map_public_ip_on_launch = false
  tags                    = {
    Name = "Test Private Subnet"
  }
}

#------------------------------------------------------------------------------
# Internet Gateway for the VPC:
#------------------------------------------------------------------------------
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.test_vpc.id
  tags   = {
    Name = "Test Internet Gateway"
  }
}

#------------------------------------------------------------------------------
# Route Table for the public subnet:
#------------------------------------------------------------------------------
resource "aws_route_table" "public_subnet_route" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "Test Route Table for Internet Gateway"
  }
}

#------------------------------------------------------------------------------
# Route Table for the private subnet:
#------------------------------------------------------------------------------
resource "aws_route_table" "private_subnet_route" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "Test Route Table for Internet Gateway"
  }
}
