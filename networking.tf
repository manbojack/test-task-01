#---------------------------------------------------------------
# Public Subnet:
#---------------------------------------------------------------
resource "aws_subnet" "public_subnet" {
  depends_on = [
    aws_vpc.test_vpc
  ]
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.10.10.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags                    = {
    Name = "Public Subnet"
  }
}

#---------------------------------------------------------------
# Private Subnet:
#---------------------------------------------------------------
resource "aws_subnet" "private_subnet" {
  depends_on = [
    aws_vpc.test_vpc,
    aws_subnet.public_subnet
  ]
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.10.20.0/24"
  availability_zone = "ap-south-1b"
  tags              = {
    Name = "Private Subnet"
  }
}

#---------------------------------------------------------------
# Internet Gateway for the VPC:
#---------------------------------------------------------------
resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    aws_vpc.test_vpc,
    aws_subnet.public_subnet,
    aws_subnet.private_subnet
  ]
  vpc_id = aws_vpc.test_vpc.id
  tags   = {
    Name = "IG-Public-&-Private-VPC"
  }
}
