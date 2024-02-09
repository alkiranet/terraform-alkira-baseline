locals {

  # filter 'billing_tag' data
  filter_billing_tags = [for vpc in var.gcp_vpc_data : vpc.billing_tag if vpc.billing_tag != null]

  # filter 'segment' data
  filter_segments     = var.gcp_vpc_data[*].segment

  # filter 'credential' data
  filter_credentials  = var.gcp_vpc_data[*].credential

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
alkira_connector_gcp_vpc
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_gcp_vpc
*/
locals {

  filter_gcp_vpcs = flatten([
    for c in var.gcp_vpc_data : {

        billing_tag       = c.billing_tag != null ? data.alkira_billing_tag.billing_tag[c.billing_tag].id : null
        credential        = lookup(data.alkira_credential.credential, c.credential, null).id
        cxp               = c.cxp
        region            = c.region
        vpc_name          = c.vpc_name
        group             = c.group
        name              = c.name
        segment           = lookup(data.alkira_segment.segment, c.segment, null).id
        size              = c.size

      }
  ])
}

resource "alkira_connector_gcp_vpc" "connector" {

  for_each = {
    for o in local.filter_gcp_vpcs : o.name => o
    if var.gcp_vpc == true
  }

  billing_tag_ids    = each.value.billing_tag != null ? [each.value.billing_tag] : []
  credential_id      = each.value.credential
  cxp                = each.value.cxp
  gcp_region         = each.value.region
  gcp_vpc_name       = each.value.vpc_name
  group              = each.value.group
  name               = each.value.name
  segment_id         = each.value.segment
  size               = each.value.size

}