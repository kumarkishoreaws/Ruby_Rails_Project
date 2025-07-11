terraform {
  backend "s3" {
    bucket  = "ror-app-terraform-state10072025"
    key     = "devkisho/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
