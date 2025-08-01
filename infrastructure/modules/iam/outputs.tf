output "ecs_task_execution_role_name" {
  description = "Name of ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.name
}

output "ecs_task_execution_role_arn" {
  description = "ARN of ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_name" {
  description = "Name of ECS Task Role"
  value       = aws_iam_role.ecs_task_role.name
}

output "ecs_task_role_arn" {
  description = "ARN of ECS Task Role"
  value       = aws_iam_role.ecs_task_role.arn
}


