#CodeDeploy 역할 생성
data "aws_iam_policy" "CodeDeployRole" {
    arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

data "aws_iam_policy_document" "codedeploy_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "CodeDeployRole" {
  name = "CTP-CodeDeployRole-${var.region_name}"
  assume_role_policy = data.aws_iam_policy_document.codedeploy_assume_role_policy.json
  managed_policy_arns = [data.aws_iam_policy.CodeDeployRole.arn]
}

# CodePipeline 역할 생성
data "aws_iam_policy_document" "pipeline_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "CodePipelineRole" {
  name = "CTP-CodePipelineRole-${var.region_name}"
  assume_role_policy = data.aws_iam_policy_document.pipeline_assume_role_policy.json
}

resource "aws_iam_role_policy" "CodePipelinePolicy" {
  name = "CTP-CodePipelinePolicy-${var.region_name}"
  role = aws_iam_role.CodePipelineRole.id
  policy = file("${path.module}/json/pipeline_policy.json")
}