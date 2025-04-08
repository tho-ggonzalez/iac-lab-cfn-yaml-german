module "rds" {
  source = "./modules/rds/"

  prefix = var.prefix
  vpc_id = module.main_vpc.vpc_id

  intra_subnets         = module.main_vpc.intra_subnets
  ecs_security_group_id = module.ecs.ecs_security_group_id

  db_name     = var.db_name
  db_username = var.db_username
}