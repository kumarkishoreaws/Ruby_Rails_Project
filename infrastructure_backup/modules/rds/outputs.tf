output "rds_endpoint" {
  value = aws_db_instance.this.address
}

output "rds_port" {
  value = aws_db_instance.this.port
}

output "rds_db_name" {
  value = var.db_name
}

output "rds_username" {
  value = aws_db_instance.this.username
}

output "rds_password" {
  value = aws_db_instance.this.password
  sensitive = true
}

