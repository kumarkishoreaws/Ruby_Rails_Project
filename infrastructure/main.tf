module "vpc" {
  source          = "./modules/vpc"
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

module "iam" {
  source         = "./modules/iam"
  project_name   = var.project_name
  s3_bucket_name = var.s3_bucket_name
}

module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  ecs_security_group_id = "sg-0ca296dde8b77a728"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "ecs" {
  source                      = "./modules/ecs"
  project_name                = var.project_name
  vpc_id                      = module.vpc.vpc_id
  private_subnet_ids          = module.vpc.private_subnet_ids
  alb_dns_name                = module.alb.alb_dns_name
  alb_target_group_arn        = module.alb.alb_target_group_arn
  alb_security_group_id       = module.alb.alb_security_group_id
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn
  rails_app_image             = "746669234934.dkr.ecr.us-east-1.amazonaws.com/ruby_rails_project_ecr:v1"
  nginx_image                 = "746669234934.dkr.ecr.us-east-1.amazonaws.com/ruby_rails_project_ecr:v2"
  rds_db_name                 = module.rds.rds_db_name
  rds_username                = module.rds.rds_username
  rds_password                = module.rds.rds_password
  rds_endpoint                = module.rds.rds_endpoint
  rds_port                    = module.rds.rds_port
  s3_bucket_name              = module.s3.bucket_name
  aws_region                  = var.aws_region
}
