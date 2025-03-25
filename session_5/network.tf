data "aws_availability_zones" "available" {
  state = "available"
}

module "main_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "${var.prefix}vpc"
  cidr = var.vpc_cidr

  azs             = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  public_subnets  = [for i in range(local.number_of_public_subnets) : cidrsubnet(var.vpc_cidr, 3, i)]
  private_subnets = [for i in range(local.number_of_private_subnets) : cidrsubnet(var.vpc_cidr, 3, i + 2)]

  enable_nat_gateway = true
  single_nat_gateway = true
  reuse_nat_ips      = false

}

resource "aws_subnet" "secure_subnets" {
  count = local.number_of_secure_subnets

  vpc_id            = module.main_vpc.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index + 4)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.prefix}secure-subnet-${count.index + 1}"
  }
}

# resource "aws_internet_gateway" "main_igw" {
#   vpc_id = module.main_vpc.vpc_id

#   tags = {
#     Name = "${var.prefix}igw"
#   }
# }

# resource "aws_route_table" "public_routetable" {
#   vpc_id = module.main_vpc.vpc_id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main_igw.id
#   }

#   tags = {
#     Name = "${var.prefix}public-routetable"
#   }
# }

# resource "aws_route_table" "private_routetable" {
#   vpc_id = module.main_vpc.vpc_id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = module.main_vpc.natgw_ids[0]
#   }

#   tags = {
#     Name = "${var.prefix}private-routetable"
#   }
# }
