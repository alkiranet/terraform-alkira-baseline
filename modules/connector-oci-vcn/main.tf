locals {

  # filter 'billing_tag' data
  filter_billing_tags = [for vcn in var.oci_vcn_data : vcn.billing_tag if vcn.billing_tag != null]

  # filter 'segment' data
  filter_segments     = var.oci_vcn_data[*].segment

  # filter 'credential' data
  filter_credentials  = var.oci_vcn_data[*].credential

}

data "alkira_billing_tag" "billing_tag" {

  for_each = toset(local.filter_billing_tags)

  name = each.value

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
alkira_connector_oci_vcn
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_oci_vcn
*/
locals {

  filter_oci_vcns = flatten([
    for c in var.oci_vcn_data : {

        # required
        billing_tag       = c.billing_tag != null ? data.alkira_billing_tag.billing_tag[c.billing_tag].id : null
        compartment_id    = c.compartment_id
        region            = c.region
        credential        = lookup(data.alkira_credential.credential, c.credential, null).id
        cxp               = c.cxp
        group             = c.group
        name              = c.name
        segment           = lookup(data.alkira_segment.segment, c.segment, null).id
        size              = c.size
        network_cidr      = c.network_cidr
        network_id        = c.network_id

      }
  ])
}

resource "alkira_connector_oci_vcn" "connector" {

  for_each = {
    for o in local.filter_oci_vcns : o.name => o
    if var.oci_vcn == true
  }

  credential_id    = each.value.credential
  billing_tag_ids  = each.value.billing_tag != null ? [each.value.billing_tag] : []
  cxp              = each.value.cxp
  name             = each.value.name
  group            = each.value.group
  oci_region       = each.value.region
  segment_id       = each.value.segment
  size             = each.value.size
  vcn_cidr         = [each.value.network_cidr]
  vcn_id           = each.value.network_id

}