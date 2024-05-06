data "alkira_policy_prefix_list" "src" {

  for_each = toset(local.filter_src_rules)
  name     = each.value

}

data "alkira_policy_rule" "rule" {
  for_each = toset(local.filter_rules)

  name = each.value

}

data "alkira_policy_prefix_list" "dst" {

  for_each = toset(local.filter_dst_rules)
  name     = each.value

}

data "alkira_segment" "segment" {

  for_each = toset(local.filter_segments)

  name = each.value

}

data "alkira_policy_rule_list" "rule_list" {

  for_each = toset(local.filter_rule_lists)

  name = each.value

}

data "alkira_group" "from" {

  for_each = {
    for k, v in toset(local.filter_from_groups) : k => v
  }

  name = each.key

}

data "alkira_group" "to" {

  for_each = {
    for k, v in toset(local.filter_to_groups) : k => v
  }

  name = each.key

}

data "alkira_internet_application" "app" {
  for_each = toset(local.filter_applications)
  name     = each.value
}

data "alkira_connector_aws_vpc" "from" {

  for_each = {
    for k, v in toset(local.filter_from_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_aws_vpc" "to" {

  for_each = {
    for k, v in toset(local.filter_to_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_azure_vnet" "from" {

  for_each = {
    for k, v in toset(local.filter_from_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_azure_vnet" "to" {

  for_each = {
    for k, v in toset(local.filter_to_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_gcp_vpc" "from" {

  for_each = {
    for k, v in toset(local.filter_from_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_gcp_vpc" "to" {

  for_each = {
    for k, v in toset(local.filter_to_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_internet_exit" "from" {

  for_each = {
    for k, v in toset(local.filter_from_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_internet_exit" "to" {

  for_each = {
    for k, v in toset(local.filter_to_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_ipsec" "from" {

  for_each = {
    for k, v in toset(local.filter_from_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_ipsec" "to" {

  for_each = {
    for k, v in toset(local.filter_to_connectors) : k => v
  }

  name = each.key

}


data "alkira_connector_oci_vcn" "from" {

  for_each = {
    for k, v in toset(local.filter_from_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_oci_vcn" "to" {

  for_each = {
    for k, v in toset(local.filter_to_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_cisco_sdwan" "from" {

  for_each = {
    for k, v in toset(local.filter_from_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_cisco_sdwan" "to" {

  for_each = {
    for k, v in toset(local.filter_to_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_aruba_edge" "from" {

  for_each = {
    for k, v in toset(local.filter_from_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_aruba_edge" "to" {

  for_each = {
    for k, v in toset(local.filter_to_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_azure_expressroute" "from" {

  for_each = {
    for k, v in toset(local.filter_from_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_azure_expressroute" "to" {

  for_each = {
    for k, v in toset(local.filter_to_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_vmware_sdwan" "from" {

  for_each = {
    for k, v in toset(local.filter_from_connectors) : k => v
  }

  name = each.key

}

data "alkira_connector_vmware_sdwan" "to" {

  for_each = {
    for k, v in toset(local.filter_to_connectors) : k => v
  }

  name = each.key

}