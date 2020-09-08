resource "aws_db_subnet_group" "default" {
  name       = "rds"
  subnet_ids = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
  #["10.0.1.0/24","10.0.2.0/24"]  

  tags = {
    Name = "DB subnet group"
  }
} 

 resource "aws_security_group" "rds-nexwebapp" {
  name        = "rds-nexwebapp"
  vpc_id      = module.vpc.vpc_id
  description = "rds nexwebapp"
 }
 resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  #cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id =  aws_security_group.rds-nexwebapp.id
  source_security_group_id  = aws_security_group.ecs-nexwebapp.id
}

resource "aws_rds_cluster" test {
cluster_identifier = var.rds_cluster_name
engine = "aurora-postgresql"
engine_version = "11.6"
database_name = var.database_name
master_username = var.master_username
master_password = var.master_password
backup_retention_period = 5
preferred_backup_window = "07:00-09:00"
vpc_security_group_ids = [aws_security_group.rds-nexwebapp.id]
db_subnet_group_name = aws_db_subnet_group.default.name
}
resource "aws_rds_cluster_instance" test-instance {
apply_immediately = true
cluster_identifier = var.rds_cluster_name
identifier = var.database_name
instance_class = "db.r5.large"
engine = "${aws_rds_cluster.test.engine}"
engine_version = "${aws_rds_cluster.test.engine_version}"
db_subnet_group_name = aws_db_subnet_group.default.name

}

