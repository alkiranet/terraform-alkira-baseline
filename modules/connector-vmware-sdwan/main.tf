locals {

  # filter 'segment' data
  filter_segments = flatten([
    for connector in var.vmware_sdwan_data : [
      for segment in connector.segment_mapping :
        segment.segment
    ]
  ])

  # filter 'billing tag' data
  filter_billing_tags = flatten([
    for connector in var.vmware_sdwan_data : [
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
alkira_connector_vmware_sdwan
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_vmware_sdwan
*/
locals {
  filter_connectors = flatten([
    for c in var.vmware_sdwan_data : {
        billing_tags           = [for billing_tag in c.billing_tags : lookup(data.alkira_billing_tag.billing_tag, billing_tag, null).id]
        cxp                    = upper(c.cxp)
        enabled                = c.enabled
        group                  = c.group
        instance               = c.instance
        name                   = c.name
        orchestrator_host      = c.orchestrator_host
        size                   = c.size
        version                = c.version

        # build new obj with original values and replace segment name -> id
        segment_mapping    = [for segment in c.segment_mapping : {
          advertise_default_route    = segment.advertise_default_route
          advertise_on_prem_routes   = segment.advertise_on_prem_routes
          customer_asn               = segment.customer_asn
          segment_id                 = lookup(data.alkira_segment.segment, segment.segment, null).id
          vmware_sdwan_segment_name  = segment.vmware_sdwan_segment_name
      }]
      }
  ])
}

resource "alkira_connector_vmware_sdwan" "connector" {

  for_each = {
    for o in local.filter_connectors : o.name => o
    if var.vmware_sdwan == true
  }

  cxp                  = each.value.cxp
  billing_tag_ids      = each.value.billing_tags
  enabled              = each.value.enabled
  group                = each.value.group
  name                 = each.value.name
  orchestrator_host    = each.value.orchestrator_host
  size                 = each.value.size
  version              = each.value.version

  dynamic "virtual_edge" {
    for_each = each.value.instance
    content {
      activation_code  = virtual_edge.value.activation_code
      hostname         = virtual_edge.value.hostname
    }
  }

  dynamic "target_segment" {
    for_each = each.value.segment_mapping
    content {
      advertise_default_route    = target_segment.value.advertise_default_route
      advertise_on_prem_routes   = target_segment.value.advertise_on_prem_routes
      gateway_bgp_asn            = target_segment.value.customer_asn
      segment_id                 = target_segment.value.segment_id
      vmware_sdwan_segment_name  = target_segment.value.vmware_sdwan_segment_name
    }
  }

}