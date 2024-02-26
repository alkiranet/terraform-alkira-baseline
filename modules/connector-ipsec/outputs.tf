output "connector_ipsec_id" {
  description = "ID of IPSec connector"
  value = {
    for k, v in alkira_connector_ipsec.connector : k => v.id
  }
}

output "connector_ipsec_implicit_group_id" {
  description = "Implicit group ID of IPSec exit connector"
  value = {
    for k, v in alkira_connector_ipsec.connector : k => v.implicit_group_id
  }
}