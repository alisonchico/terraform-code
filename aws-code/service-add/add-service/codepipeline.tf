#
# codepipeline - nexwebapp
#
resource "aws_codebuild_source_credential" "example1" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = "PERSONALTOKEN"
}
resource "aws_codepipeline" "nexwebapp" {
  name     = var.servicename
  role_arn = "${var.codepipeline_project_servicerole}"

  artifact_store {
    location = var.location
    type     = "S3"
   # encryption_key {
    #  id   = aws_kms_alias.nexwebapp-artifacts.arn
     # type = "KMS"
    #}
  }
   stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["${var.servicename}-source"]

      configuration = {
        Owner  =      var.Owner 
        Repo   =      var.Repo 
        Branch =      var.branch
        OAuthToken =  var.OAuthToken
      }
    }
  }


  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["${var.servicename}-source"]
      output_artifacts = ["${var.servicename}-build"]
      version          = "1"

      configuration = {
        ProjectName = var.servicename
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "DeployToECS"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["${var.servicename}-build"]
      version         = "1"

      configuration = {
        ApplicationName                = aws_codedeploy_app.nexwebapp.name
        DeploymentGroupName            = aws_codedeploy_deployment_group.nexwebapp.deployment_group_name
        TaskDefinitionTemplateArtifact = "${var.servicename}-build"
        AppSpecTemplateArtifact        = "${var.servicename}-build"
      }
    }
  }
}


