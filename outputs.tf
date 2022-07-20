output "billing_tag_id" {
  description = "Alkira billing tag ID"
  value = {
    for k, v in alkira_billing_tag.tag : k => v.id
  }
}

output "connector_group_id" {
  description = "Alkira connector group ID"
  value = {
    for k, v in alkira_group_connector.group : k => v.id
  }
}

output "prefix_list_id" {
  description = "Alkira prefix-list ID"
  value = {
    for k, v in alkira_policy_prefix_list.list : k => v.id
  }
}

output "segment_id" {
  description = "Alkira segment ID"
  value = {
    for k, v in alkira_segment.segment : k => v.id
  }
}


output "user_group_id" {
  description = "Alkira user group ID"
  value = {
    for k, v in alkira_group_user.group : k => v.id
  }
}