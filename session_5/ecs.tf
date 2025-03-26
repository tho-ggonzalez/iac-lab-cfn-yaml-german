module "ecs" {
  source = "./modules/ecs/"

  prefix                = var.prefix
  region                = var.region
  vpc_id                = module.main_vpc.vpc_id
  private_subnet_ids    = module.main_vpc.private_subnets
  alb_target_group_arn  = aws_lb_target_group.tg.arn
  alb_security_group_id = aws_security_group.lb_sg.id
  db_address            = module.rds.rds_address
  db_name               = var.db_name
  db_username           = var.db_username
  db_secret_arn         = local.db_secret_arn
  db_secret_key_id      = local.db_secret_key_id
}