module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.48.0"

  name = "vpc-module-nexwebapp"
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    "Name" = "terraform-cloudpipeline-nexwebapp"
  }
}
resource "aws_security_group" "ecs-nexwebapp" {
  name        = "ECS nexwebapp"
  vpc_id      = module.vpc.vpc_id
  description = "ECS nexwebapp"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description  = "http"
  }
   ingress {
    description  = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}