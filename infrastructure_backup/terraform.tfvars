project_name = "ror-app-Kisho"
vpc_cidr     = "10.0.0.0/16"

public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

azs = ["us-east-1a", "us-east-1b"]

db_name     = "rorappdb"
db_username = "roruser"
db_password = "rorKisho312"
