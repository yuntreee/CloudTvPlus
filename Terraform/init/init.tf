provider "aws" {
  region  = "ap-northeast-2"
  access_key = ""
  secret_key = ""
}

# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.account_id}-apnortheast2-tfstate"

  versioning {
    enabled = true
  }
  force_destroy = true
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-lock-${var.account_id}"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# s3 bucket name
variable "account_id" {
  default = "cloudtv9" # Please use the account alias for id
}
