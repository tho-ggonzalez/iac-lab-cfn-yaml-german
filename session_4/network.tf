data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  count = local.number_of_public_subnets

  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.prefix}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet3_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.prefix}-private-subnet-1"
  }
}

resource "aws_subnet" "secure_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet5_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.prefix}-secure-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet4_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.prefix}-private-subnet-2"
  }
}

resource "aws_subnet" "secure_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet6_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.prefix}-secure-subnet-2"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[1].id

  tags = {
    Name = "${var.prefix}-nat-gw"
  }
}

resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "${var.prefix}-public-routetable"
  }
}

resource "aws_route_table" "private_routetable" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.prefix}-private-routetable"
  }
}

resource "aws_route_table_association" "public_routetable_associations" {
  count = 2

  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_routetable.id
}

resource "aws_route_table_association" "private_routetable_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_routetable.id
}

resource "aws_route_table_association" "private_routetable_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_routetable.id
}
