# Creating custom vpc to launch resources
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name        = "${var.client}-vpc"
  }
}

# Creating IGW for Custom VPC for Internet Connectivity
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.client}-igw"
  }
}

# Creating Public Subnets
resource "aws_subnet" "pub-subs" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet("10.0.1.0/20", 4, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.client}-Public-Subnet-${count.index}"
  }
}

# Creating Private Subnets
resource "aws_subnet" "pri-subs" {
  count             = 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet("10.0.3.0/20", 4, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.client}-Private-Subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}

# Creating Public Route Table
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Creating Elastic IP for NAT Gateway
resource "aws_eip" "eip" {
  domain = "vpc"
}

# Creating NAT Gateway in first public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub-subs[0].id
}

# Creating Private Route Table
resource "aws_route_table" "pri-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "pub-asso" {
  count          = 2
  subnet_id      = aws_subnet.pub-subs[count.index].id
  route_table_id = aws_route_table.pub-rt.id
}

# Route table association with private subnets
resource "aws_route_table_association" "pri-asso" {
  count          = 2
  subnet_id      = aws_subnet.pri-subs[count.index].id
  route_table_id = aws_route_table.pri-rt.id
}