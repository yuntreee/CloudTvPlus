data "terraform_remote_state" "seoul" {
  backend = "s3"

  config = { 
    bucket = "${var.account_id}-apnortheast2-tfstate"
    key     = "aws/seoul/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
