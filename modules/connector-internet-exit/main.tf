locals {

  # filter 'segment' data
  filter_segments   = var.connector_internet_data[*].segment

  # filter 'billing tag' data
  filter_billing_tags = flatten([
    for connector in var.connector_internet_data : [
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
alkira_connector_internet_exit
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_internet_exit
*/

locals {

  filter_internet_connectors = flatten([
    for c in var.connector_internet_data : {

        # required
        cxp                                       = upper(c.cxp)
        name                                      = c.name
        segment                                   = lookup(data.alkira_segment.segment, c.segment, null).id
        
        # optional
        billing_tags                              = [for billing_tag in c.billing_tags : lookup(data.alkira_billing_tag.billing_tag, billing_tag, null).id]
        description                               = c.description
        enabled                                   = c.enabled
        group                                     = c.group
        public_ip_number                          = c.public_ip_number
        traffic_distribution_algorithm            = c.traffic_distribution_algorithm
        traffic_distribution_algorithm_attribute  = c.traffic_distribution_algorithm_attribute

      }
  ])
}

resource "alkira_connector_internet_exit" "connector" {

  for_each = {
    for o in local.filter_internet_connectors : o.name => o
    if var.connector_internet == true
  }

  # required
  cxp                                             = each.value.cxp
  name                                            = each.value.name
  segment_id                                      = each.value.segment

  # optional
  billing_tag_ids                                 = each.value.billing_tags
  description                                     = each.value.description
  enabled                                         = each.value.enabled
  group                                           = each.value.group
  public_ip_number                                = each.value.public_ip_number
  traffic_distribution_algorithm                  = each.value.traffic_distribution_algorithm
  traffic_distribution_algorithm_attribute        = each.value.traffic_distribution_algorithm_attribute

}