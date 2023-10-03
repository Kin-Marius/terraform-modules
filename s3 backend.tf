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

