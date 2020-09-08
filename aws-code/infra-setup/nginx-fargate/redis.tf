resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis"
  subnet_ids = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
  #["10.0.1.0/24","10.0.2.0/24"]  
} 

 resource "aws_security_group" "redis" {
  name        = "redis-nexwebapp"
  vpc_id      = module.vpc.vpc_id
  description = "redis-nexwebapp"
 
 }
 resource "aws_security_group_rule" "redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  #cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id =  aws_security_group.redis.id
  source_security_group_id  = aws_security_group.ecs-nexwebapp.id
}

resource "aws_elasticache_cluster" "redis" {
    cluster_id = var.redis_cluster_id
    engine = "redis"
    node_type = "cache.t2.micro"
    port = 6379
    num_cache_nodes = 1
    security_group_ids = [aws_security_group.redis.id]
    subnet_group_name = aws_elasticache_subnet_group.redis.name
}


