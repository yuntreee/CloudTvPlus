# Route 53 Hosting Zone
resource "aws_route53_zone" "route53zone" {
  name = var.domain_name
}

# # ACM
# resource "aws_acm_certificate" "acm" {
#   domain_name = "*.${var.domain_name}"
#   validation_method = "DNS"
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # ACM DNS 인증
# resource "aws_route53_record" "acm-record" {
#   for_each = {
#     for dvo in aws_acm_certificate.acm.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.route53zone.zone_id
# }

# resource "aws_acm_certificate_validation" "acm-validate" {
#   certificate_arn         = aws_acm_certificate.acm.arn
#   validation_record_fqdns = [for record in aws_route53_record.acm-record : record.fqdn]
# }

# Route53 www record
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.route53zone.zone_id
  name = "www.${var.domain_name}"
  type = "A"
  alias {
    name = aws_globalaccelerator_accelerator.ctp_globalaccelerator.dns_name
    zone_id = aws_globalaccelerator_accelerator.ctp_globalaccelerator.hosted_zone_id
    evaluate_target_health = true
  }
}

# Global Accelerator
resource "aws_globalaccelerator_accelerator" "ctp_globalaccelerator" {
    name            = "ctp-globalaccelerator"
    ip_address_type = "IPV4"
    enabled         = true

    tags = {
        Name = "ctp_globalaccelerator"
    }
}

resource "aws_globalaccelerator_listener" "ctp_globalaccelerator_listener" {

    accelerator_arn = aws_globalaccelerator_accelerator.ctp_globalaccelerator.id
    client_affinity = "SOURCE_IP"
    protocol        = "TCP"

    port_range {
        from_port = 443
        to_port   = 443
    }
}

resource "aws_globalaccelerator_endpoint_group" "ctp_globalaccelerator_endgroup" {
    count = length(var.lb_arn)
    listener_arn = aws_globalaccelerator_listener.ctp_globalaccelerator_listener.id
    endpoint_configuration {
        endpoint_id = var.lb_arn[count.index]
        weight      = 100
    }
}