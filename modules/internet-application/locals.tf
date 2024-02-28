locals {
  # Filter 'billing_tag' data
  filter_billing_tags = [for application in var.internet_application_data : application.billing_tag if application.billing_tag != null]

  # Filter 'segment' data
  filter_segments = var.internet_application_data[*].segment

  # Filter 'connector' data for each type
  filter_aws_vpc_connectors      = [for application in var.internet_application_data : application.connector_name if application.connector_type == "aws_vpc"]
  filter_azure_vnet_connectors   = [for application in var.internet_application_data : application.connector_name if application.connector_type == "azure_vnet"]
  filter_gcp_vpc_connectors      = [for application in var.internet_application_data : application.connector_name if application.connector_type == "gcp_vpc"]
  filter_oci_vcn_connectors      = [for application in var.internet_application_data : application.connector_name if application.connector_type == "oci_vcn"]

  # Dynamically determine connector_id
  connector_ids = {for application in var.internet_application_data : application.name => 
    application.connector_type == "aws_vpc" ? (try(data.alkira_connector_aws_vpc.connector[application.connector_name].id, null)) :
    application.connector_type == "azure_vnet" ? (try(data.alkira_connector_azure_vnet.connector[application.connector_name].id, null)) :
    application.connector_type == "gcp_vpc" ? (try(data.alkira_connector_gcp_vpc.connector[application.connector_name].id, null)) :
    application.connector_type == "oci_vcn" ? (try(data.alkira_connector_oci_vcn.connector[application.connector_name].id, null)) :
    null}
}

locals {

  filter_internet_applications = flatten([
    for c in var.internet_application_data : {

      # filter base configuration
      billing_tag_id  = c.billing_tag != null ? data.alkira_billing_tag.billing_tag[c.billing_tag].id : null
      connector_type  = upper(c.connector_type)
      connector_id    = local.connector_ids[c.name]
      fqdn_prefix     = c.fqdn_prefix
      name            = c.name
      segment_id      = lookup(data.alkira_segment.segment, c.segment, null).id
      size            = c.size

      # filter segment options
      target = {
        port_ranges  = c.target["port_ranges"]
        type         = upper(c.target["type"])
        value        = c.target["value"]
      }

    }
  ])
}