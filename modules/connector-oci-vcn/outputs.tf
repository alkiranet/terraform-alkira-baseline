output "connector_oci_id" {
  description = "ID of OCI connector"
  value = {
    for k, v in alkira_connector_oci_vcn.connector : k => v.id
  }
}

output "connector_oci_implicit_group_id" {
  description = "Implicit group ID of OCI connector"
  value = {
    for k, v in alkira_connector_oci_vcn.connector : k => v.implicit_group_id
  }
}