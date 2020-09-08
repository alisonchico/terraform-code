resource "aws_lb" "nexwebapp" {
  name                             = "nexwebapp"
  subnets                          = module.vpc.public_subnets
  load_balancer_type               = "application"
  security_groups    = ["${aws_security_group.ecs-nexwebapp.id}"]
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "front_end_https" {
  load_balancer_arn = "${aws_lb.nexwebapp.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-west-1:061520891697:certificate/6a46f980-a0e8-409c-aac1-0fbdce4fbf1f"

    default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.nexwebapp.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
