data "aws_route53_zone" "mydomain" {
  name         = "suryatestdomain.com"
  #private_zone = true
}


#output
output "mydomain_zoneID" {
    description = "value"
    value = data.aws_route53_zone.mydomain.zone_id

}

