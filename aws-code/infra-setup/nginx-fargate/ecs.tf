resource "aws_ecs_cluster" "nexwebapp" {
  name = "${var.cluster_name}"
}

