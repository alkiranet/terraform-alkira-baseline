output "alkira_connector_azure_id" {
  description = "ID of Azure connector"
  value = {
    for k, v in alkira_connector_azure_vnet.connector : k => v.id
  }
}

output "alkira_connector_azure_implicit_group_id" {
  description = "Implicit group ID of Azure connector"
  value = {
    for k, v in alkira_connector_azure_vnet.connector : k => v.implicit_group_id
  }
}