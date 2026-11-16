terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment to keep state in S3 with locking
  # backend "s3" {
  #   bucket         = "<STATE_BUCKET>"
  #   key            = "terraform-aws-infra/terraform.tfstate"
  #   region         = "ap-southeast-1"
  #   dynamodb_table = "<LOCK_TABLE>"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project   = var.project
      ManagedBy = "terraform"
    }
  }
}
