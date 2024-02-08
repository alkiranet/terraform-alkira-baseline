locals {

  # filter 'segment' data
  filter_segments     = var.azure_vnet_data[*].segment

  # filter 'credential' data
  filter_credentials  = var.azure_vnet_data[*].credential

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
alkira_connector_azure_vnet
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_azure_vnet
*/
locals {

  filter_azure_vnets = flatten([
    for c in var.azure_vnet_data : {

        credential        = lookup(data.alkira_credential.credential, c.credential, null).id
        cxp               = c.cxp
        group             = c.group
        name              = c.name
        network_cidr      = c.network_cidr
        network_id        = c.network_id
        segment           = lookup(data.alkira_segment.segment, c.segment, null).id
        size              = c.size

      }
  ])
}

resource "alkira_connector_azure_vnet" "connector" {

  for_each = {
    for o in local.filter_azure_vnets : o.name => o
    if var.azure_vnet == true
  }

  azure_vnet_id           = each.value.network_id
  credential_id           = each.value.credential
  cxp                     = each.value.cxp
  group                   = each.value.group
  name                    = each.value.name
  segment_id              = each.value.segment
  size                    = each.value.size

  vnet_cidr {
    cidr             = each.value.network_cidr
    routing_options  = "ADVERTISE_DEFAULT_ROUTE"
  }

}