
# CodeDeploy Application
resource "aws_codedeploy_app" "CodeDeploy" {
  name = "CTP-CodeDeploy-${var.region_name}"
}

resource "aws_codedeploy_deployment_group" "DeployGroup" {
  app_name = aws_codedeploy_app.CodeDeploy.name
  deployment_group_name = "CTP-DeployGroup-${var.region_name}"
  service_role_arn = aws_iam_role.CodeDeployRole.arn
  autoscaling_groups = [ var.autoscaling_group_name ]
  
  load_balancer_info {
    target_group_info {
      name = var.alb_target_group_name
    }
  }
}

# CodePipeline Artifact Store
resource "aws_s3_bucket" "artifact-store" {
  bucket = "ctp-artifact-store-${var.region_name}-${var.account_id}"
  acl = "public-read"
  force_destroy = true
}

# Artifact Store bucket policy
data "template_file" "artifact_policy" {
  template = file("${path.module}/json/artifact_store_policy.json")
  vars = {
    artifactS3Arn = aws_s3_bucket.artifact-store.arn
  }
}

resource "aws_s3_bucket_policy" "artifact-store-policy" {
  bucket = aws_s3_bucket.artifact-store.id
  policy = data.template_file.artifact_policy.rendered
}

# CodePipeline & Github 연결
resource "aws_codestarconnections_connection" "git-connect" {
  name = "codestar-connection"
  provider_type = "GitHub"
}

# CodePipeline
resource "aws_codepipeline" "CodePipeline" {
  name = "CTP-CodePipeline-${var.region_name}"
  role_arn = aws_iam_role.CodePipelineRole.arn
  artifact_store {
    location = aws_s3_bucket.artifact-store.id
    type = "S3"
  }

  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeStarSourceConnection"
      version = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn = aws_codestarconnections_connection.git-connect.arn
        FullRepositoryId = var.GitRepo_name
        BranchName = "main"
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name = "Deploy"
      category = "Deploy"
      owner = "AWS"
      provider = "CodeDeploy"
      version = "1"
      input_artifacts = ["source_output"]
      configuration = {
        ApplicationName = aws_codedeploy_app.CodeDeploy.name
        DeploymentGroupName = "CTP-DeployGroup-${var.region_name}"
      }
    }
  }
}