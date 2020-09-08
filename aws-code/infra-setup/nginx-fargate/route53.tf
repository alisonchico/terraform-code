resource "aws_route53_record" "backend" {
  zone_id = "Z03359891N3CN5MA2IXV7"
  name    = "${var.url}"
  type    = "A"


alias {
    name                   = "${aws_lb.nexwebapp.dns_name}"
    zone_id                = "${aws_lb.nexwebapp.zone_id}"
    evaluate_target_health = true
  }
}