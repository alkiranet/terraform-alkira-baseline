/*
alkira_billing_tag
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/billing_tag
*/
resource "alkira_billing_tag" "tag" {

  for_each = {
    for o in var.billing_tag_data : o.name => o
    if var.billing_tag == true
  }

  name        = each.value.name
  description = each.value.description

}

/*
alkira_group
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/group
*/
resource "alkira_group" "group" {

  for_each = {
    for o in var.group_data : o.name => o
    if var.group == true
  }

  name        = each.value.name
  description = each.value.description

}

/*
alkira_list_global_cidr
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/list_global_cidr
*/
resource "alkira_list_global_cidr" "list" {

  for_each = {
    for o in var.global_cidr_list_data : o.name => o
    if var.global_cidr_list == true
  }

  name        = each.value.name
  description = each.value.description
  values      = each.value.values
  cxp         = each.value.cxp

}


/*
alkira_policy_prefix_list
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy_prefix_list
*/
resource "alkira_policy_prefix_list" "list" {

  for_each = {
    for o in var.prefix_list_data : o.name => o
    if var.prefix_list == true
  }

  name        = each.value.name
  description = each.value.description
  prefixes    = each.value.values

}

/*
alkira_segment
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/segment
*/
resource "alkira_segment" "segment" {

  for_each = {
    for o in var.segment_data : o.name => o
    if var.segment == true
  }

  # required
  cidrs  = each.value.cidrs
  name   = each.value.name

  # optional
  asn                              = each.value.asn
  description                      = each.value.description
  enable_ipv6_to_ipv4_translation  = each.value.enable_ipv6_to_ipv4_translation
  enterprise_dns_server_ip         = each.value.enterprise_dns_server_ip
  reserve_public_ips               = each.value.reserve_public_ips
  src_ipv4_pool_end_ip             = each.value.src_ipv4_pool_end_ip
  src_ipv4_pool_start_ip           = each.value.src_ipv4_pool_start_ip

}