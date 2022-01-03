output "acm_certificate" {
  value = module.acm.acm_certificate
}

output "db_arn" {
  value = module.rds.db_arn
}

output "db_dns" {
  value = module.rds.db_dns
}

output "ga_listener" {
  value = module.domain.ga_listener
}

output "dns_zone_id" {
  value = module.domain.dns_zone_id
}