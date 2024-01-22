output "service_pan_id" {
  description = "ID of PAN service"
  value = {
    for k, v in alkira_service_pan.service : k => v.id
  }
}