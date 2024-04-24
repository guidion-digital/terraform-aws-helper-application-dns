output "role_arns" {
  value = module.assume_roles.application_iam_role_arns
}

output "domain_nameservers" {
  value = {
    for k, v in aws_route53_zone.these : k => v.name_servers
  }
}

output "zone_ids" {
  value = {
    for k, v in aws_route53_zone.these : k => v.zone_id
  }
}
