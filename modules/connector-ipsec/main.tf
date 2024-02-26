locals {

  # filter 'segment' data
  filter_segments   = var.connector_ipsec_data[*].segment

  # filter 'billing_tag' data
  filter_billing_tags = flatten([
    for connector in var.connector_ipsec_data : [
      for endpoint in connector.endpoints : [
        for billing_tag in endpoint.billing_tags : billing_tag
      ]
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

resource "random_string" "psk" {
  count    = 2
  length   = 32
  special  = true
}

/*
alkira_connector_ipsec
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_ipsec
*/
locals {

  filter_ipsec_connectors = flatten([
    for c in var.connector_ipsec_data : {

        # filter base configuration
        cxp            = upper(c.cxp)
        enabled        = c.enabled
        group          = c.group
        name           = c.name
        segment_id     = lookup(data.alkira_segment.segment, c.segment, null).id
        size           = c.size
        
        # filter endpoints
        endpoints  = [for endpoint in c.endpoints : {
          billing_tags              = [for billing_tag in endpoint.billing_tags : lookup(data.alkira_billing_tag.billing_tag, billing_tag, null).id]
          customer_gateway_ip       = endpoint.customer_gateway_ip
          enable_tunnel_redundancy  = endpoint.enable_tunnel_redundancy
          name                      = endpoint.name
          preshared_keys            = length(endpoint.preshared_keys) > 0 ? endpoint.preshared_keys : [
            random_string.psk[0].result,
            random_string.psk[1].result,
        ]
      }]

      # filter routing options
      routing_options = {
        availability          = c.routing_options["availability"]
        bgp_auth_key          = c.routing_options["bgp_auth_key"]
        customer_gateway_asn  = c.routing_options["customer_gateway_asn"]
        type                  = c.routing_options["type"]
      }

      # filter segment options
      segment_options = {
        advertise_default_route   = try(c.segment_options.advertise_default_route, false),
        advertise_on_prem_routes  = try(c.segment_options.advertise_on_prem_routes, false),
        segment_name              = try(lookup(data.alkira_segment.segment, c.segment, null).name, "")
      }
      # segment_options = {
      #   advertise_default_route   = c.segment_options["advertise_default_route"]
      #   advertise_on_prem_routes  = c.segment_options["advertise_on_prem_routes"]
      #   segment_name              = lookup(data.alkira_segment.segment, c.segment, null).name
      # }

    }
  ])
}

resource "alkira_connector_ipsec" "connector" {

  for_each = {
    for o in local.filter_ipsec_connectors : o.name => o
    if var.connector_ipsec == true
  }

  cxp         = upper(each.value.cxp)
  enabled     = each.value.enabled
  group       = each.value.group
  name        = each.value.name
  segment_id  = each.value.segment_id
  size        = each.value.size
  vpn_mode    = "ROUTE_BASED"

  dynamic "endpoint" {
    for_each = each.value.endpoints
    content {
      billing_tag_ids           = endpoint.value.billing_tags
      customer_gateway_ip       = endpoint.value.customer_gateway_ip
      enable_tunnel_redundancy  = endpoint.value.enable_tunnel_redundancy
      name                      = endpoint.value.name
      preshared_keys            = endpoint.value.preshared_keys
    }
  }

  routing_options {
    availability          = each.value.routing_options.availability
    bgp_auth_key          = each.value.routing_options.bgp_auth_key
    customer_gateway_asn  = each.value.routing_options.customer_gateway_asn
    type                  = each.value.routing_options.type
  }

  segment_options {
    advertise_default_route   = each.value.segment_options.advertise_default_route
    advertise_on_prem_routes  = each.value.segment_options.advertise_on_prem_routes
    name                      = each.value.segment_options.segment_name
  }

}