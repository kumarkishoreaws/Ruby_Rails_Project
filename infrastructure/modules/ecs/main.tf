resource "aws_security_group" "ecs_service_sg" {
  name        = "${var.project_name}-ecs-service-sg"
  description = "Allow traffic from ALB to ECS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
    description     = "Allow traffic from ALB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ecs-service-sg"
  }
}

resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-cluster"
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "rails-app"
      image     = var.rails_app_image
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = [
        { name = "RDS_DB_NAME",    value = var.rds_db_name },
        { name = "RDS_USERNAME",   value = var.rds_username },
        { name = "RDS_PASSWORD",   value = var.rds_password },
        { name = "RDS_HOSTNAME",   value = var.rds_endpoint },
        { name = "RDS_PORT",       value = tostring(var.rds_port) },
        { name = "S3_BUCKET_NAME", value = var.s3_bucket_name },
        { name = "S3_REGION_NAME", value = var.aws_region },
        { name = "LB_ENDPOINT",    value = var.alb_dns_name }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.project_name}"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "rails"
        }
      }
    },
    {
      name      = "nginx"
      image     = var.nginx_image
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      dependsOn = [
        {
          containerName = "rails-app"
          condition     = "START"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.project_name}"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "nginx"
        }
      }
    }
  ])

  
  depends_on = [aws_cloudwatch_log_group.ecs_log_group]
}

resource "aws_ecs_service" "this" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [aws_ecs_task_definition.this]
}
