output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "nat_gateway_ids" {
  value = module.vpc.nat_gateway_ids
}

output "nat_eip_ids" {
  value = module.vpc.nat_eip_ids
}

output "ecs_task_execution_role_name" {
  value = module.iam.ecs_task_execution_role_name
}

output "ecs_task_execution_role_arn" {
  value = module.iam.ecs_task_execution_role_arn
}

output "ecs_task_role_name" {
  value = module.iam.ecs_task_role_name
}

output "ecs_task_role_arn" {
  value = module.iam.ecs_task_role_arn
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_port" {
  value = module.rds.rds_port
}

output "rds_db_name" {
  value = module.rds.rds_db_name
}

output "rds_username" {
  value = module.rds.rds_username
}

output "rds_password" {
  value     = module.rds.rds_password
  sensitive = true
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}

output "alb_dns_name" {
  description = "DNS of the ALB"
  value       = module.alb.alb_dns_name
}

output "alb_target_group_arn" {
  value = module.alb.alb_target_group_arn
}

output "alb_security_group_id" {
  value = module.alb.alb_security_group_id
}

