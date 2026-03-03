module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "6.3.0"
  domain_name = trimsuffix(data.aws_route53_zone.mydomain.name, ".")
  zone_id     = data.aws_route53_zone.mydomain.zone_id

   subject_alternative_names = [
    #"*.suryatestdomain.com"
    var.dev_DNS_name
  ]

  validation_method = "DNS"

  tags = {
    Name = "suryatestdomain.com"
  }

}


#Certificate ARN
output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}