#App1 DNS Name
resource "aws_route53_record" "asg1_record" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = "dev.suryatestdomain.com"
  type    = "A"
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}


#App2 DNS Name
#resource "aws_route53_record" "asg2_record" {
#  zone_id = data.aws_route53_zone.mydomain.zone_id
#  name    = "asg2.suryatestdomain.com"
#  type    = "A"
#  alias {
#    name                   = module.alb.dns_name
#    zone_id                = module.alb.zone_id
#    evaluate_target_health = true
#  }
#}