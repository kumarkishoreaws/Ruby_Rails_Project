output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "alb_security_group_id" {
  description = "Security Group ID of the ALB"
  value       = aws_security_group.alb_sg.id
}

output "alb_target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.this.arn
}
