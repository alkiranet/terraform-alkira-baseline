output "alkira_connector_aws_id" {
  description = "ID of AWS connector"
  value = {
    for k, v in alkira_connector_aws_vpc.connector : k => v.id
  }
}

output "alkira_connector_aws_implicit_group_id" {
  description = "Implicit group ID of AWS connector"
  value = {
    for k, v in alkira_connector_aws_vpc.connector : k => v.implicit_group_id
  }
}