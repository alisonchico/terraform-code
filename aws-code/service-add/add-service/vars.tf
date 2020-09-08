variable "AWS_REGION" {
  default = "us-west-1"
}
variable "servicename" {
 }
variable "RDS-HOST" {
 }

variable "RDS-username" {
 }

variable "RDS_Password" {
 }
variable "Redis_Host" {
 }

variable "Owner"{
}
variable "branch"{
}
variable "Repo"{
}
variable "OAuthToken"{
}
variable "build_timeout"{
}

variable "containerPort"{
}
  


variable "aws_codebuild_project_service_role"{
  default = "arn:aws:iam::061520891697:role/nexwebapp-codebuild"
}
variable "codedeploy_service_role"{
  default = "arn:aws:iam::061520891697:role/nexwebapp-codedeploy"
}
variable "cluster_name"{
}

variable "ecs_task_definition_servicerole"{
  default = "arn:aws:iam::061520891697:role/ecs-task-execution-role"
}     
variable "location"{
} 
variable "codepipeline_project_servicerole"{
  default = "arn:aws:iam::061520891697:role/nexwebapp-codepipeline"
} 

variable "execution_role_arn"{
  default = "arn:aws:iam::061520891697:role/ecs-task-execution-role"
}     

variable "task_role_arn"{
  default = "arn:aws:iam::061520891697:role/ecs-nexwebapp-task-role"
}  
variable "vpc_id"{
}  
variable "subnet" {

}

variable "security_groups" {
  
}

#variable "load_balancer_arn" {
  
#}

variable "ecs_cluster_id" {
  
}

variable "path" {
  
}


variable "listener_arn" {
  
}


variable "health_check"{
  
}


