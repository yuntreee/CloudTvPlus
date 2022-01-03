# 원본영상 들어갈 S3
resource "aws_s3_bucket" "input_video" {
  bucket = "ctp-input-videos-${var.account_id}"
  acl = "private"
  force_destroy = true

  # CORS 설정
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }

  # LifeCycle 설정
  lifecycle_rule {
    id = "original video"
    enabled = true
    transition {
      days = 30
      storage_class = "GLACIER"
    }
  }
}

# Lambda만 input S3 버킷에 접근 허용 하는 정책
data "template_file" "inputS3Policy" {
  template = file("${path.module}/json/input_S3_policy.json")

  vars = {
    LambdaRoleArn = aws_iam_role.LambdaRole.arn
    inputS3Arn = aws_s3_bucket.input_video.arn
  }
}

resource "aws_s3_bucket_policy" "inputS3Policy" {
  bucket = aws_s3_bucket.input_video.id
  policy = data.template_file.inputS3Policy.rendered
}

# HLS로 변환된 영상 들어갈 S3
resource "aws_s3_bucket" "output_video" {
  bucket = "ctp-output-videos-${var.account_id}"
  acl = "private"
  force_destroy = true
  
  # CORS 설정
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_public_access_block" "outputS3Block" {
  bucket = aws_s3_bucket.output_video.id
  ignore_public_acls = true
  restrict_public_buckets = true
  block_public_policy = true
}

# CloudFront에 사용될 OAI
resource "aws_cloudfront_origin_access_identity" "OAI" {
  comment = "CloudFront OAI"
}

# CloudFront
resource "aws_cloudfront_distribution" "CF" {
  origin {
    domain_name = aws_s3_bucket.output_video.bucket_regional_domain_name
    origin_id = aws_s3_bucket.output_video.bucket_regional_domain_name

    # OAI 사용
    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.OAI.id}"
    }
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.output_video.bucket_regional_domain_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
   geo_restriction {
     restriction_type = "none"
   } 
  }

  enabled = true
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# OAI를 사용하는 리소스만 버킷에 접근 가능하도록 하는 정책
data "template_file" "oai_policy" {
  template = file("${path.module}/json/oai_policy.json")

  vars = {
    oaiArn = aws_cloudfront_origin_access_identity.OAI.iam_arn
    outputS3Arn = aws_s3_bucket.output_video.arn
  }
}

# output S3에 OAI 정책 설정
resource "aws_s3_bucket_policy" "OAIPolicy" {
  bucket = aws_s3_bucket.output_video.id
  policy = data.template_file.oai_policy.rendered
}


#Lambda 함수
resource "aws_lambda_function" "LambdaFunction" {
  filename = "${path.module}/videoconvert.zip"
  function_name = "CTP-VOD-Convert-${var.region_name}"
  role = aws_iam_role.LambdaRole.arn
  handler = "convert.handler"
  runtime = "python3.7"
  timeout = 300
  environment {
    variables = {
      DestinationBucket = "${aws_s3_bucket.output_video.id}"
      MediaConvertRole = "${aws_iam_role.MediaConvertRole.arn}"
      Application = "VOD"
    }
  }
}

# S3 트리거
resource "aws_s3_bucket_notification" "s3-trigger" {
  bucket = aws_s3_bucket.input_video.id
  lambda_function {
    lambda_function_arn = "${aws_lambda_function.LambdaFunction.arn}"
    # S3의 upload 폴더에 객체가 생성되면 트리거 작동
    events = ["s3:ObjectCreated:*"]
    filter_prefix = "upload/"
  }
}

# S3가 Lambda에 접근할 수 있도록 허가
resource "aws_lambda_permission" "trigger-permission" {
  statement_id = "AllowS3Invoke"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.LambdaFunction.function_name}"
  principal = "s3.amazonaws.com"
  source_arn = "${aws_s3_bucket.input_video.arn}"
}