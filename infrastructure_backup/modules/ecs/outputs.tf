output "ecs_cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "ecs_service_sg_id" {
  value = aws_security_group.ecs_service_sg.id
}
