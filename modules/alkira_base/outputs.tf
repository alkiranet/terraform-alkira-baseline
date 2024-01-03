output "billing_tag_id" {
  description = "ID of billing tag"
  value = {
    for k, v in alkira_billing_tag.tag : k => v.id
  }
}

output "group_id" {
  description = "ID of group"
  value = {
    for k, v in alkira_group.group : k => v.id
  }
}

output "global_cidr_list_id" {
  description = "ID of global cidr list"
  value = {
    for k, v in alkira_list_global_cidr.list : k => v.id
  }
}

output "prefix_list_id" {
  description = "ID of prefix list"
  value = {
    for k, v in alkira_policy_prefix_list.list : k => v.id
  }
}

output "segment_id" {
  description = "ID of segment"
  value = {
    for k, v in alkira_segment.segment : k => v.id
  }
}