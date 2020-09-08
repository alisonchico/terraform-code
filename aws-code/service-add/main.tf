#Inputs Generated at Infra Module
module "serviceadd" {
source = "./add-service"
OAuthToken = "904e888f310f86acea1466a9e89079e35b2bb06c"
Owner  = "devopsrajpurohit"
Repo   = "NexSimpleDockerWebApp"
branch = "master"
build_timeout = "20"
containerPort = "80"
health_check = "/health"

#Need to Change - Inputs for Service-ADD
RDS-HOST = "nexwebapp.cluster-cne3z6hmyfpn.us-west-1.rds.amazonaws.com"
RDS-username = "nexwebapp"
RDS_Password = "nexwebapp"
Redis_Host = "nexwebapp.60h3uj.0001.usw1.cache.amazonaws.com"
servicename = "applicationgm1"
path= "privacy"
listener_arn ="arn:aws:elasticloadbalancing:us-west-1:061520891697:listener/app/nexwebapp/889dc0504eba576e/8a6d98a2cf02dbba"
cluster_name = "nexwebapp"
ecs_cluster_id = "arn:aws:ecs:us-west-1:061520891697:cluster/nexwebapp"
location = "nexwebapp-artifacts-tbxvga0y"
security_groups = [
  "sg-02995e87e5dd8c060",
]
subnet = [
  "subnet-060c76623c920c538",
  "subnet-0b3008185ef32cf58",
]
vpc_id = "vpc-012d2415a9a406c9a"
}

