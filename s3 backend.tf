terraform {
  required_version = "~> 1.2" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "bootcamp32-${lower(var.my_env)}-${random_integer.priority.result}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_kms_key" "my_key" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
}

resource "random_integer" "priority" {
  min = 1
  max = 100
  keepers = {
    # Generate a new integer each time we switch to a new listener ARN
    Environment = var.my_env
  }
}

