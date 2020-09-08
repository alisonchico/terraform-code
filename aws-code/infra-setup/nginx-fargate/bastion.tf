resource "aws_instance" "server" {
  ami                         = "ami-098cbf06e5c8bb8a3"
  instance_type               = "t3.medium"
  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = [aws_security_group.ecs-nexwebapp.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 100
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name    = "Bastion host"
   
  }
}