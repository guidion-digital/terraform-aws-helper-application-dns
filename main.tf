resource "aws_route53_zone" "these" {
  for_each = toset(var.zones)

  name = each.value
}

data "aws_iam_policy_document" "this" {
  depends_on = [aws_route53_zone.these]

  statement {
    sid = "dnsread"
    actions = [
      "route53:GetHostedZone",
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource"
    ]
    resources = [for this_zone in aws_route53_zone.these : this_zone.arn]
  }

  statement {
    sid = "dnscreate"
    actions = [
      "route53:CreateHostedZone",
      "route53:GetChange",
      "route53:ListHostedZones",
      "route53:ListHostedZonesByName"
    ]
    resources = [
      "*"
    ]
  }
}
# Created here, because it's values must be known to the roles module
resource "aws_iam_policy" "this" {
  name   = "${var.name}-networking-zones"
  path   = "/infrastructure/"
  policy = data.aws_iam_policy_document.this.json
}

# These are needed by the application workspaces, so that they can manage their
# own DNS records
module "assume_roles" {
  source  = "app.terraform.io/guidion/infra-iam-roles/aws"
  version = "~> 0.0"

  application = "networking"
  project     = var.name
  namespace   = "workspaces"

  roles = {
    "zones" = {
      policy_arns     = [aws_iam_policy.this.arn]
      assume_accounts = var.assume_accounts
    }
  }
}
