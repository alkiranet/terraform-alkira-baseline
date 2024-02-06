output "connector_vmware_sdwan_id" {
  description = "ID of VMware SDWAN connector"
  value = {
    for k, v in alkira_connector_vmware_sdwan.connector : k => v.id
  }
}

output "connector_vmware_sdwan_implicit_group_id" {
  description = "Implicit group ID of VMware SDWAN connector"
  value = {
    for k, v in alkira_connector_vmware_sdwan.connector : k => v.implicit_group_id
  }
}