resource "aws_codedeploy_app" "nexwebapp" {
  compute_platform = "ECS"
  name             = var.servicename
}

resource "aws_codedeploy_deployment_group" "nexwebapp" {
  app_name               = var.servicename
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = var.servicename
  service_role_arn       = var.codedeploy_service_role
  depends_on             = ["aws_ecs_service.nexwebapp"]

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = "nexwebapp"
    service_name = var.servicename
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.listener_arn]
      }

      target_group {
        name = aws_lb_target_group.nexwebapp-blue.name
      }

      target_group {
        name = aws_lb_target_group.nexwebapp-green.name
      }
    }
  }
}
