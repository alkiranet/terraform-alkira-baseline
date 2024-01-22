locals {

  # filter 'segment' data for 'management_segment'
  filter_mgmt_segments = var.pan_service_data[*].management_segment

  # filter 'segment' data for service
  filter_segments = flatten([
    for connector in var.pan_service_data : [
      for segment in connector.segments :
        segment
    ]
  ])

  # filter 'segment' data for 'segment_options'
  filter_zone_segments = flatten([
    for connector in var.pan_service_data : [
      for segment in connector.segment_options :
        segment.segment
    ]
  ])

  # filter 'billing tag' data
  filter_billing_tags = flatten([
    for connector in var.pan_service_data : [
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
alkira_service_pan
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/service_pan
*/
locals {
  filter_connectors = flatten([
    for c in var.pan_service_data : {
        billing_tags             = [for billing_tag in c.billing_tags : lookup(data.alkira_billing_tag.billing_tag, billing_tag, null).id]
        bundle                   = c.bundle
        cxp                      = upper(c.cxp)
        instance                 = c.instance
        license_type             = c.license_type
        management_segment       = lookup(data.alkira_segment.mgmt_segment, c.management_segment, null).id 
        max_instance_count       = c.max_instance_count
        name                     = c.name
        password                 = c.password
        registration_pin_expiry  = c.registration_pin_expiry 
        registration_pin_id      = c.registration_pin_id
        registration_pin_value   = c.registration_pin_value
        segments                 = [for segment in c.segments : lookup(data.alkira_segment.segment, segment, null).id]
        size                     = c.size
        type                     = c.type
        username                 = c.username
        version                  = c.version

        # build new obj with original values and replace segment name -> id
        segment_options  = [for segment in c.segment_options : {
          groups         = segment.groups
          segment_id     = lookup(data.alkira_segment.zone_segment, segment.segment, null).id
          zone_name      = segment.zone_name
      }]
      }
  ])
}

resource "alkira_service_pan" "service" {

  for_each = {
    for o in local.filter_connectors : o.name => o
    if var.service_pan == true
  }

  billing_tag_ids         = each.value.billing_tags
  bundle                  = each.value.bundle
  cxp                     = each.value.cxp
  license_type            = each.value.license_type
  management_segment_id   = each.value.management_segment
  max_instance_count      = each.value.max_instance_count
  name                    = each.value.name
  pan_username            = each.value.username
  pan_password            = each.value.password
  registration_pin_expiry = each.value.registration_pin_expiry
  registration_pin_id     = each.value.registration_pin_id
  registration_pin_value  = each.value.registration_pin_value
  segment_ids             = each.value.segments
  size                    = each.value.size
  type                    = each.value.type
  version                 = each.value.version

  instance {
    name  = each.value.instance
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