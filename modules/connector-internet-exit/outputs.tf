output "connector_internet_id" {
  description = "ID of internet exit connector"
  value = {
    for k, v in alkira_connector_internet_exit.connector : k => v.id
  }
}

output "connector_internet_implicit_group_id" {
  description = "Implicit group ID of internet exit connector"
  value = {
    for k, v in alkira_connector_internet_exit.connector : k => v.implicit_group_id
  }
}