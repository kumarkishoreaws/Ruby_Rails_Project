Infrastructure Setup – Ruby on Rails App Deployment using Terraform on AWS

This folder contains Terraform code to deploy the Ruby on Rails (RoR) application in AWS using ECS Fargate, Nginx as a reverse proxy, RDS for PostgreSQL, and S3 for file storage. The infrastructure is built following security best practices with private networking and IAM roles — fully automated using Terraform.



What This Setup Does



This setup provisions:



1. A custom VPC with public and private subnets across two AZs
2. ECS Cluster with Fargate tasks running two containers:
3. Rails app container  (port 3000)
4. Nginx container  as reverse proxy (port 80)
5. Application Load Balancer (ALB) in public subnet
6 .RDS (PostgreSQL 13.19) instance in private subnet
7. S3 bucket for file storage (IAM-based access only)
8 .IAM roles for ECS task execution and S3 access
9.  NAT Gateway for internet access from private subnets




How to Deploy the Infrastructure

  Prerequisites

Make sure the following tools are installed and configured:

1.AWS CLI (`aws configure`)
2. Terraform 
3. Docker (for building and pushing app/Nginx images to ECR)
4 .Git (for code versioning)






 Deployment Steps

 Go to the infrastructure directory:

   cd infrastructure/
   terraform  fmt
   terraform init
   terraform validate
   terraform plan
   terraform apply






Configuration – terraform.tfvars

This is what we define in the terraform.tfvars file:
project_name = "ror-app-Kisho"
vpc_cidr     = "10.0.0.0/16"

public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

azs = ["us-east-1a", "us-east-1b"]

db_name     = "rorappdb"
db_username = "roruser"
db_password = "rorKisho312"
These variables are customizable. Everything else (like ALB DNS, RDS endpoint, etc.) will be automatically created by Terraform and printed as output after successful deployment.







Terraform Outputs:

After successful deployment, Terraform returns the following:
•	alb_dns_name = "ror-app-Kisho-alb-2094697819.us-east-1.elb.amazonaws.com"
•	rds_endpoint = "ror-app-kisho-postgres-db.cbk2aaak4n88.us-east-1.rds.amazonaws.com"
•	rds_username = "roruser"
•	rds_db_name  = "rorappdb"
•	rds_port     = 5432
•	s3_bucket_name = "ror-app-assets-bucket"
•	s3_bucket_arn  = "arn:aws:s3:::ror-app-assets-bucket"
•	ecs_task_execution_role_name = "ror-app-Kisho-ecs-execution-role"
•	ecs_task_execution_role_arn  = "arn:aws:iam::746669234934:role/ror-app-Kisho-ecs-execution-role"
•	ecs_task_role_name = "ror-app-Kisho-ecs-task-role"
•	ecs_task_role_arn  = "arn:aws:iam::746669234934:role/ror-app-Kisho-ecs-task-role"
•	vpc_id = "vpc-08f373b00e3c2d3dd"
•	public_subnet_ids = [
  "subnet-0b43e4f492a7c2b52",
  "subnet-0d1e464c830863335"
]
•	private_subnet_ids = [
  "subnet-02e2303fdbf517352",
  "subnet-0330902dae74d0432"
]
•	nat_gateway_ids = ["nat-01fb02bf44e1045f6"]
•	internet_gateway_id = "igw-0819595cb33e0f129"






1.  The Rails application listens on port 3000, while Nginx listens on port 80 and forwards traffic to the Rails container using the alias rails_app.
2.  Both containers (Rails and Nginx) run inside the same ECS Fargate task definition.
3.  The Dockerfiles for Rails and Nginx are located under the /docker folder.
4. Terraform stores temporary files in .terraform/, which is excluded via .gitignore.
5.  Only the ALB is exposed to the internet. All containers and databases are deployed in private subnets.
6.  IAM roles are used for S3 access. No static access keys or secrets are used.
7.  Docker images should be built and pushed to AWS ECR before running terraform apply.


