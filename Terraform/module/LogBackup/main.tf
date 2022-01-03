

# 로그 저장될 S3
resource "aws_s3_bucket" "logs" {
  bucket = "ctp-logs-${var.region_name}-${var.account_id}"
  acl = "private"
  force_destroy = true

  # LifeCycle 설정
  lifecycle_rule {
    id = "Logs"
    enabled = true
    transition {
      days = 30
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "logS3Block" {
  bucket = aws_s3_bucket.logs.id
  ignore_public_acls = true
  restrict_public_buckets = true
  block_public_policy = true
}

# CloudWatch가 S3 버킷에 접근 허용하는 정책
data "template_file" "LogS3Policy" {
  template = file("${path.module}/json/log_S3_policy.json")
  vars = {
    Region = var.region
    LogS3Arn = aws_s3_bucket.logs.arn
  }
}

resource "aws_s3_bucket_policy" "LogS3Policy" {
  bucket = aws_s3_bucket.logs.id
  policy = data.template_file.LogS3Policy.rendered
}

# Lambda 역할 생성
data "aws_iam_policy" "S3FullAccess" {
    arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "CloudWatchFullAccess" {
    arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
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
  name = "CTP-LambdaCWRole-${var.region_name}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
  managed_policy_arns = [
      data.aws_iam_policy.S3FullAccess.arn,
      data.aws_iam_policy.CloudWatchFullAccess.arn]
}

# CloudWatch로그 S3로 백업하는 Lambda 함수
resource "aws_lambda_function" "LambdaFunction" {
  filename = "${path.module}/log_backup.zip"
  function_name = "CTP-Log-Backup-${var.region_name}"
  role = aws_iam_role.LambdaRole.arn
  handler = "Log_Backup.handler"
  runtime = "python3.7"
  timeout = 600
  environment {
    variables = {
      S3_BUCKET = "${aws_s3_bucket.logs.id}"
      HOURS = "${var.n_hours}"
    }
  }
}

# EventBridge로 N시간마다 Lambda 호출
resource "aws_cloudwatch_event_rule" "eventbridge" {
  name        = "Log_EventBridge"
  description = "called every N hours"
  schedule_expression = "rate(${var.n_hours} hours)"
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule = aws_cloudwatch_event_rule.eventbridge.name
  target_id = "TriggerLambda"
  arn = aws_lambda_function.LambdaFunction.arn
}

resource "aws_lambda_permission" "trigger-permission" {
  statement_id = "AllowCloudWatchInvoke"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.LambdaFunction.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.eventbridge.arn
}