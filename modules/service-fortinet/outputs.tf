output "service_fortinet_id" {
  description = "ID of Fortinet service"
  value = {
    for k, v in alkira_service_fortinet.service : k => v.id
  }
}