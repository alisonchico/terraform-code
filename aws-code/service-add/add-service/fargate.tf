resource "aws_ecs_task_definition" "nexwebap" {
  family = var.servicename
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  cpu                = 256
  memory             = 512
  network_mode       = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]

  container_definitions = <<DEFINITION
[
  {
    "essential": true,
    "image": "${aws_ecr_repository.nexwebapp.repository_url}",
    "name": "${var.servicename}",
    "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
               "awslogs-group" : "${var.servicename}",
               "awslogs-region": "${var.AWS_REGION}",
               "awslogs-stream-prefix": "ecs"
            }
     },
     "secrets": [],
     "environment": [
        {
          "name": "Redis_Host",
          "value":"${var.Redis_Host}" 
        },
         {
          "name": "RDS_HOST",
          "value": "${var.RDS-HOST}" 
         },
          {
          "name": "RDS_Username",
          "value": "${var.RDS-username}" 
         },
          {
          "name": "RDS_Password",
          "value": "${var.RDS_Password}" 
         }

       ],
     "healthCheck": {
       "command": [ "CMD-SHELL", "echo hi || exit 1" ],
       "interval": 30,
       "retries": 3,
       "timeout": 5
     },
     "portMappings": [
        {
           "containerPort": 80,
           "hostPort": 80,
           "protocol": "tcp"
        }
     ]
  }
]
DEFINITION

}

resource "aws_ecs_service" "nexwebapp" {
  name            = var.servicename
  cluster         = var.ecs_cluster_id
  desired_count   = 1
  task_definition = aws_ecs_task_definition.nexwebap.arn
  launch_type     = "FARGATE"
  depends_on      = ["aws_lb_listener_rule.static"]

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = var.subnet
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nexwebapp-blue.id
    container_name   = var.servicename
    container_port   = var.containerPort
  }
  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer
    ]
  }
}

# security group

# logs
resource "aws_cloudwatch_log_group" "nginx" {
  name = "${var.servicename}"
}

