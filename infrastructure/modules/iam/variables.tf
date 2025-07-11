variable "project_name" {
  description = "Project prefix"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name to allow access from ECS task"
  type        = string
}
