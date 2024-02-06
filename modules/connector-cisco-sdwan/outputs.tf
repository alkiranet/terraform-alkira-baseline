output "connector_cisco_sdwan_id" {
  description = "ID of Cisco SDWAN connector"
  value = {
    for k, v in alkira_connector_cisco_sdwan.connector : k => v.id
  }
}

output "connector_cisco_sdwan_implicit_group_id" {
  description = "Implicit group ID of Cisco SDWAN connector"
  value = {
    for k, v in alkira_connector_cisco_sdwan.connector : k => v.implicit_group_id
  }
}