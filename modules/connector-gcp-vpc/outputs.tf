output "alkira_connector_gcp_id" {
  description = "ID of GCP connector"
  value = {
    for k, v in alkira_connector_gcp_vpc.connector : k => v.id
  }
}

output "alkira_connector_gcp_implicit_group_id" {
  description = "Implicit group ID of GCP connector"
  value = {
    for k, v in alkira_connector_gcp_vpc.connector : k => v.implicit_group_id
  }
}