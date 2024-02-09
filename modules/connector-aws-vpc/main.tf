locals {

  # filter 'billing_tag' data
  filter_billing_tags = [for vpc in var.aws_vpc_data : vpc.billing_tag if vpc.billing_tag != null]

  # filter 'segment' data
  filter_segments     = var.aws_vpc_data[*].segment

  # filter 'credential' data
  filter_credentials  = var.aws_vpc_data[*].credential

}

data "alkira_billing_tag" "billing_tag" {

  for_each = toset(local.filter_billing_tags)

  name = each.value

}

data "alkira_segment" "segment" {

  for_each = toset(local.filter_segments)

  name = each.value

}

data "alkira_credential" "credential" {

  for_each = toset(local.filter_credentials)

  name = each.value

}

/*
alkira_connector_aws_vpc
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_aws_vpc
*/
locals {
  filter_aws_vpcs = flatten([
    for c in var.aws_vpc_data : {
        aws_account_id   = c.aws_account_id
        billing_tag      = c.billing_tag != null ? data.alkira_billing_tag.billing_tag[c.billing_tag].id : null
        credential       = lookup(data.alkira_credential.credential, c.credential, null).id
        cxp              = upper(c.cxp)
        enabled          = c.enabled
        group            = c.group
        name             = c.name
        network_cidr     = c.network_cidr
        network_id       = c.network_id
        region           = c.region
        route_table_id   = c.route_table_id
        segment          = lookup(data.alkira_segment.segment, c.segment, null).id
        size             = c.size
      }
  ])
}

resource "alkira_connector_aws_vpc" "connector" {

  for_each = {
    for o in local.filter_aws_vpcs : o.name => o
    if var.aws_vpc == true
  }

  aws_account_id   = each.value.aws_account_id
  aws_region       = each.value.region
  billing_tag_ids  = each.value.billing_tag != null ? [each.value.billing_tag] : []
  credential_id    = each.value.credential
  cxp              = each.value.cxp
  enabled          = each.value.enabled
  group            = each.value.group
  name             = each.value.name
  segment_id       = each.value.segment
  size             = each.value.size
  vpc_cidr         = [each.value.network_cidr]
  vpc_id           = each.value.network_id

  vpc_route_table {
    id       = each.value.route_table_id
    options  = "ADVERTISE_DEFAULT_ROUTE"
  }

}