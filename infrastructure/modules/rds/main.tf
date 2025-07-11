resource "aws_db_subnet_group" "this" {
  name       = "${lower(var.project_name)}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${lower(var.project_name)}-db-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow ECS to access RDS"
  vpc_id      = var.vpc_id

   ingress {
   from_port       = 5432
   to_port         = 5432
   protocol        = "tcp"
   security_groups = [var.ecs_security_group_id]
   description     = "Allow ECS access"
   }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

resource "aws_db_instance" "this" {
  identifier             = "${lower(var.project_name)}-postgres-db"
  engine                 = "postgres"
  engine_version         = "13.21"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = 5432
  publicly_accessible    = false
  multi_az               = false
  storage_encrypted      = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.this.name
  skip_final_snapshot    = true

  tags = {
    Name = "${var.project_name}-postgres-db"
  }
}
