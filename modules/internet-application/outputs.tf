output "internet_application_id" {
  description = "ID of Internet Application"
  value = {
    for k, v in alkira_internet_application.application : k => v.id
  }
}

output "internet_application_group_id" {
  description = "Group ID of Internet Application"
  value = {
    for k, v in alkira_internet_application.application : k => v.group_id
  }
}