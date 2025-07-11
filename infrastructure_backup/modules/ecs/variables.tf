variable "project_name" {}
variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "alb_dns_name" {}
variable "alb_target_group_arn" {}
variable "alb_security_group_id" {}

variable "ecs_task_execution_role_arn" {}
variable "ecs_task_role_arn" {}

variable "rails_app_image" {}
variable "nginx_image" {}

variable "rds_db_name" {}
variable "rds_username" {}
variable "rds_password" {
  sensitive = true
}
variable "rds_endpoint" {}
variable "rds_port" {}

variable "s3_bucket_name" {}
variable "aws_region" {}
