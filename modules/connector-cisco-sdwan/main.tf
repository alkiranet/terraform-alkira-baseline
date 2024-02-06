locals {

  # filter 'segment' data
  filter_segments = flatten([
    for connector in var.cisco_sdwan_data : [
      for vrf_segment in connector.vrf_segment_mapping :
        vrf_segment.segment
    ]
  ])

  # filter 'billing tag' data
  filter_billing_tags = flatten([
    for connector in var.cisco_sdwan_data : [
      for billing_tag in connector.billing_tags :
        billing_tag
    ]
  ])

}

data "alkira_segment" "segment" {

  for_each = toset(local.filter_segments)

  name = each.value

}

data "alkira_billing_tag" "billing_tag" {

  for_each = {
    for k, v in toset(local.filter_billing_tags) : k => v
  }

  name = each.key

}

/*
alkira_connector_cisco_sdwan
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_cisco_sdwan
*/
locals {
  filter_connectors = flatten([
    for c in var.cisco_sdwan_data : {
        cxp                    = upper(c.cxp)
        instance               = c.instance
        name                   = c.name
        billing_tags           = [for billing_tag in c.billing_tags : lookup(data.alkira_billing_tag.billing_tag, billing_tag, null).id]
        enabled                = c.enabled
        group                  = c.group
        size                   = c.size
        type                   = c.type
        version                = c.version

        # build new obj with original values and replace segment name -> id
        vrf_segment_mapping    = [for vrf_segment in c.vrf_segment_mapping : {
          customer_asn = vrf_segment.customer_asn
          vrf_id       = vrf_segment.vrf_id
          segment_id   = lookup(data.alkira_segment.segment, vrf_segment.segment, null).id
      }]
      }
  ])
}

resource "alkira_connector_cisco_sdwan" "connector" {

  for_each = {
    for o in local.filter_connectors : o.name => o
    if var.cisco_sdwan == true
  }

  cxp                  = each.value.cxp
  billing_tag_ids      = each.value.billing_tags
  enabled              = each.value.enabled
  group                = each.value.group
  name                 = each.value.name
  size                 = each.value.size
  version              = each.value.version

  dynamic "vedge" {
    for_each = each.value.type == "vedge" ? each.value.instance : []
    content {
      hostname        = vedge.value.hostname
      cloud_init_file = vedge.value.cloud_init_file
      username        = vedge.value.username
      password        = vedge.value.password
    }
  }

  dynamic "vrf_segment_mapping" {
    for_each = each.value.vrf_segment_mapping
    content {
      customer_asn  = vrf_segment_mapping.value.customer_asn
      segment_id    = vrf_segment_mapping.value.segment_id
      vrf_id        = vrf_segment_mapping.value.vrf_id
    }
  }

}