resource "alkira_internet_application" "application" {

  for_each = {
    for o in local.filter_internet_applications : o.name => o
    if var.internet_application == true
  }

  billing_tag_ids  = each.value.billing_tag_id
  connector_id     = each.value.connector_id
  connector_type   = upper(each.value.connector_type)
  fqdn_prefix      = each.value.fqdn_prefix
  name             = each.value.name
  segment_id       = each.value.segment_id
  size             = each.value.size

  target {
    port_ranges   = each.value.target.port_ranges
    type          = upper(each.value.target.type)
    value         = each.value.target.value
  }

}