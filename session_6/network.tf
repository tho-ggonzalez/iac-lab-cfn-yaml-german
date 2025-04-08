data "aws_availability_zones" "available" {
  state = "available"
}

module "main_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "${var.prefix}vpc"
  cidr = var.vpc_cidr

  azs             = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  public_subnets  = [for i in range(local.number_of_public_subnets) : cidrsubnet(var.vpc_cidr, 3, i)]
  private_subnets = [for i in range(local.number_of_private_subnets) : cidrsubnet(var.vpc_cidr, 3, i + 2)]
  intra_subnets   = [for i in range(local.number_of_secure_subnets) : cidrsubnet(var.vpc_cidr, 3, i + 4)]

  enable_nat_gateway = true
  single_nat_gateway = true
  reuse_nat_ips      = false

}
