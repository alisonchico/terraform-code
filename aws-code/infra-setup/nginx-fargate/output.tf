output "codebuild_project_servicerole" {
  value = aws_iam_role.nexwebapp-codebuild.arn
}
output "aws_codedeploy_deployment_group_servicerole" {
  value = aws_iam_role.nexwebapp-codedeploy.arn
}
output "aws_ecs_task_definition_servicerole" {
  value = aws_iam_role.ecs-task-execution-role.arn
}
output "Redis_Host" {
  value = aws_elasticache_cluster.redis.cache_nodes.0.address
}
output "RDS-username" {
  value = aws_rds_cluster.test.master_username
}
  
output "RDS_HOST" {
  value =  aws_rds_cluster.test.endpoint
}
output "RDS_Password" {
  value = aws_rds_cluster.test.master_password
}
output "codepipeline_project_servicerole" {
  value = aws_iam_role.nexwebapp-codepipeline.arn

}

output "location"{
    value = aws_s3_bucket.nexwebapp-artifacts.bucket
}

output "execution_role_arn"{
    value =  aws_iam_role.ecs-task-execution-role.arn
}
output "task_role_arn"{
    value =  aws_iam_role.ecs-nexwebapp-task-role.arn
}

output "ecs_cluster_id"{
   value =  aws_ecs_cluster.nexwebapp.id
} 
output "vpc_id" {
    value =  module.vpc.vpc_id
}

output "load_balancer_arn" {
    value = aws_lb.nexwebapp.arn
}

output "subnet" {
  value = slice(module.vpc.public_subnets, 0, 2)
}

output "security_groups" {
  value = [aws_security_group.ecs-nexwebapp.id]
}

output "lb_dns"{
value = aws_lb.nexwebapp.dns_name
}
output "listener_arn"{
value = aws_lb_listener.front_end_https.arn
}
