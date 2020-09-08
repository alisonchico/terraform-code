# code build
resource "aws_codebuild_project" "nexwebapp" {
  name           = var.servicename
  description    = "${var.servicename}-docker build"
  build_timeout  = var.build_timeout
  service_role   = var.aws_codebuild_project_service_role
  #encryption_key = var.encryption_key
  artifacts {
    type = "CODEPIPELINE"
  }

  #cache {
  #  type     = "S3"
  #  location = aws_s3_bucket.codebuild-cache.bucket
  #}

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/docker:18.09.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.AWS_REGION
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = aws_ecr_repository.nexwebapp.name
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  #depends_on      = [aws_s3_bucket.codebuild-cache]
}

