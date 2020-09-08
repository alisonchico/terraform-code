module "infra-setup" {
  source = "./nginx-fargate"
database_name = "nexwebapp"
master_password = "nexwebapp"
master_username = "nexwebapp"
rds_cluster_name = "nexwebapp"
redis_cluster_id = "nexwebapp"
cluster_name = "nexwebapp"
url = "api.nexwebapp.com."
}
output "example_module_outputs" {
  value = module.infra-setup
}
