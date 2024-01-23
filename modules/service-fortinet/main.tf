locals {

  # filter 'segment' data for 'management_segment'
  filter_mgmt_segments = var.fortinet_service_data[*].management_segment

  # filter 'segment' data for service
  filter_segments = flatten([
    for connector in var.fortinet_service_data : [
      for segment in connector.segments :
        segment
    ]
  ])

  # filter 'segment' data for 'segment_options'
  filter_zone_segments = flatten([
    for connector in var.fortinet_service_data : [
      for segment in connector.segment_options :
        segment.segment
    ]
  ])

  # filter 'billing tag' data
  filter_billing_tags = flatten([
    for connector in var.fortinet_service_data : [
      for billing_tag in connector.billing_tags :
        billing_tag
    ]
  ])

}

data "alkira_segment" "mgmt_segment" {

  for_each = toset(local.filter_mgmt_segments)

  name     = each.value

}

data "alkira_segment" "segment" {

  for_each = {
    for k, v in toset(local.filter_segments) : k => v
  }

  name = each.key

}

data "alkira_segment" "zone_segment" {

  for_each = toset(local.filter_zone_segments)

  name = each.value

}

data "alkira_billing_tag" "billing_tag" {

  for_each = {
    for k, v in toset(local.filter_billing_tags) : k => v
  }

  name = each.key

}

/*
alkira_service_fortinet
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/service_fortinet
*/
locals {
  filter_connectors = flatten([
    for c in var.fortinet_service_data : {
        auto_scale               = upper(c.auto_scale)
        billing_tags             = [for billing_tag in c.billing_tags : lookup(data.alkira_billing_tag.billing_tag, billing_tag, null).id]
        cxp                      = upper(c.cxp)
        license_type             = c.license_type
        management_segment       = lookup(data.alkira_segment.mgmt_segment, c.management_segment, null).id 
        max_instance_count       = c.max_instance_count
        min_instance_count       = c.min_instance_count
        name                     = c.name
        password                 = c.password
        segments                 = [for segment in c.segments : lookup(data.alkira_segment.segment, segment, null).id]
        size                     = c.size
        tunnel_protocol          = c.tunnel_protocol
        username                 = c.username
        version                  = c.version

        instances  = [for instance in c.instances : {
          name                   = instance.name
          license_key_file_path  = instance.license_key_file_path
        }]

        # build new obj with original values and replace segment name -> id
        segment_options  = [for segment in c.segment_options : {
          groups         = segment.groups
          segment_id     = lookup(data.alkira_segment.zone_segment, segment.segment, null).id
          zone_name      = segment.zone_name
      }]
      }
  ])
}

resource "alkira_service_fortinet" "service" {

  for_each = {
    for o in local.filter_connectors : o.name => o
    if var.service_fortinet == true
  }

  auto_scale                    = each.value.auto_scale
  billing_tag_ids               = each.value.billing_tags
  cxp                           = each.value.cxp
  license_type                  = each.value.license_type
  management_server_segment_id  = each.value.management_segment
  max_instance_count            = each.value.max_instance_count
  min_instance_count            = each.value.min_instance_count
  name                          = each.value.name
  username                      = each.value.username
  password                      = each.value.password
  segment_ids                   = each.value.segments
  size                          = each.value.size
  tunnel_protocol               = each.value.tunnel_protocol
  version                       = each.value.version

  dynamic "instances" {
    for_each = each.value.instances
    content {
      name                  = instances.value.name
      license_key_file_path = instances.value.license_key_file_path
    }
  }

  dynamic "segment_options" {
    for_each = each.value.segment_options
    content {
      groups     = segment_options.value.groups
      segment_id = segment_options.value.segment_id
      zone_name  = segment_options.value.zone_name
    }
  }

}