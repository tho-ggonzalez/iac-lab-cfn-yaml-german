resource "aws_vpc" "main-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.subnet1_cidr
  availability_zone = var.az_a

  tags = {
    Name = "${var.prefix}-public-subnet-1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.subnet2_cidr
  availability_zone = var.az_a

  tags = {
    Name = "${var.prefix}-private-subnet-2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.subnet3_cidr
  availability_zone = var.az_a

  tags = {
    Name = "${var.prefix}-secure-subnet-3"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.subnet4_cidr
  availability_zone = var.az_b

  tags = {
    Name = "${var.prefix}-public-subnet-4"
  }
}

resource "aws_subnet" "subnet5" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.subnet5_cidr
  availability_zone = var.az_b

  tags = {
    Name = "${var.prefix}-private-subnet-5"
  }
}

resource "aws_subnet" "subnet6" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.subnet6_cidr
  availability_zone = var.az_b

  tags = {
    Name = "${var.prefix}-secure-subnet-6"
  }
}

resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}