variable "project_name" {
  description = "Prefix for all resources"
  type        = string
  default     = "ror-app"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}


variable "s3_bucket_name" {
  default = "ror-app-assets-bucket"
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "db_username" {
  description = "PostgreSQL username"
  type        = string
}

variable "db_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}


variable "aws_region" {
  description = "AWS Region where resources will be created"
  type        = string
  default     = "us-east-1"
}
