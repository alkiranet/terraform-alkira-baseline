data "alkira_billing_tag" "billing_tag" {

  for_each = toset(local.filter_billing_tags)

  name = each.value

}

data "alkira_connector_aws_vpc" "connector" {

  for_each = toset(local.filter_aws_vpc_connectors)

  name = each.value

}

data "alkira_connector_azure_vnet" "connector" {

  for_each = toset(local.filter_azure_vnet_connectors)

  name = each.value

}

data "alkira_connector_gcp_vpc" "connector" {

  for_each = toset(local.filter_gcp_vpc_connectors)

  name = each.value

}

data "alkira_connector_oci_vcn" "connector" {

  for_each = toset(local.filter_oci_vcn_connectors)

  name = each.value

}

data "alkira_segment" "segment" {

  for_each = toset(local.filter_segments)

  name = each.value

}