# EC2 S3 & Dynamodb & Secret Manager full access
data "aws_iam_policy" "S3FullAccess" {
    arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "DynamoDBFullAccess" {
    arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

data "aws_iam_policy" "SecretMangaerReadWrite" {
    arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "EC2Role" {
  name = "CTP-EC2Role-${var.region_name}"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
  managed_policy_arns = [
      data.aws_iam_policy.S3FullAccess.arn,
      data.aws_iam_policy.DynamoDBFullAccess.arn,
      data.aws_iam_policy.SecretMangaerReadWrite.arn]
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "ec2_profile-${var.region_name}"
  role = aws_iam_role.EC2Role.name
}