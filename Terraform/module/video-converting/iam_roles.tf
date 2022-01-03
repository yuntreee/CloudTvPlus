# MediaConvert 역할 생성
data "aws_iam_policy" "APIGatewayInvokeFullAccess" {
    arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess"
}

data "aws_iam_policy" "S3FullAccess" {
    arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy_document" "mediaconvert_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["mediaconvert.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "MediaConvertRole" {
  name = "CTP-MediaConvertRole-${var.region_name}"
  assume_role_policy = data.aws_iam_policy_document.mediaconvert_assume_role_policy.json
  managed_policy_arns = [
      data.aws_iam_policy.S3FullAccess.arn,
      data.aws_iam_policy.APIGatewayInvokeFullAccess.arn
      ]
}

# Lambda 역할 생성
data "aws_iam_policy" "LambdaBasicExecutionRole" {
    arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "template_file" "lambda_policy" {
  template = file("${path.module}/json/lambda_policy.json")
  vars = {
    MediaConvertRoleArn = aws_iam_role.MediaConvertRole.arn
    inputS3Arn = aws_s3_bucket.input_video.arn
    outputS3Arn = aws_s3_bucket.output_video.arn
  }
}

# lambda가 S3, MediaConvert에 접근하도록 허용하는 정책
resource "aws_iam_role_policy" "LambdaMediaConvertPolicy" {
  name = "CTP-LambdaMediaConvertPolicy-${var.region_name}"
  role = aws_iam_role.LambdaRole.id
  policy = data.template_file.lambda_policy.rendered
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions    = ["sts:AssumeRole"]
    effect     = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "LambdaRole" {
  name = "CTP-LambdaRole-${var.region_name}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
  managed_policy_arns = [data.aws_iam_policy.LambdaBasicExecutionRole.arn]
}