variable "test_zones" {}

module "application_dns" {
  for_each = var.test_zones

  source = "../../"

  name            = each.key
  zones           = each.value.zones
  assume_accounts = each.value.accounts
}
