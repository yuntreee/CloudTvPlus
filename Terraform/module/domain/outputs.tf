# output "acm_certificate" {
#   value = aws_acm_certificate.acm.arn
# }

output "ga_listener" {
  value = aws_globalaccelerator_listener.ctp_globalaccelerator_listener.id
}

output "dns_zone_id" {
  value = aws_route53_zone.route53zone.zone_id
}