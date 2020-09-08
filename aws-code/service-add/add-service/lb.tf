resource "aws_lb_listener_rule" "static" {
 # l#istener_arn = "${aws_lb_listener.front_end.arn}"
 listener_arn = "${var.listener_arn}"
  priority     = 100

  action {
    type             = "forward"
    forward {
    
       target_group {
       arn = "${aws_lb_target_group.nexwebapp-green.arn}" 
       weight           = 0
         } 

       target_group {
       arn = "${aws_lb_target_group.nexwebapp-blue.arn}" 
       weight           = 100
         } 
   }
   }

  condition {
    path_pattern {
      values = ["/${var.path}"]
    }
  }
}




resource "aws_lb_target_group" "nexwebapp-blue" {
  name                 = "${var.servicename}-http-blue"
  port                 = "80"
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = "30"

  health_check {
    healthy_threshold   = 2
    path                =  var.health_check
    unhealthy_threshold = 2
    protocol            = "HTTP"
    interval            = 30
  }
}
resource "aws_lb_target_group" "nexwebapp-green" {
  name                 = "${var.servicename}-http-green"
  port                 = "80"
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = "30"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "HTTP"
    interval            = 30
  }
}
