output "connector_cisco_sdwan_id" {
  description = "ID of Cisco SDWAN connector"
  value = try(module.connector_cisco_sdwan.*.connector_cisco_sdwan_id, "")
}

output "connector_cisco_sdwan_implicit_group_id" {
  description = "Implicit group ID of Cisco SDWAN connector"
  value = try(module.connector_cisco_sdwan.*.connector_cisco_sdwan_implicit_group_id, "")
}

output "connector_internet_id" {
  description = "ID of internet exit connector"
  value = try(module.connector_internet.*.connector_internet_id, "")
}

output "connector_internet_implicit_group_id" {
  description = "Implicit group ID of internet exit connector"
  value = try(module.connector_internet.*.connector_internet_implicit_group_id, "")
}

output "billing_tag_id" {
  description = "ID of billing tag"
  value = try(module.billing_tag.*.billing_tag_id, "")
}

output "group_id" {
  description = "ID of group"
  value = try(module.group.*.group_id, "")
}

output "global_cidr_list_id" {
  description = "ID of global cidr list"
  value = try(module.global_cidr_list.*.global_cidr_list_id, "")
}

output "prefix_list_id" {
  description = "ID of prefix list"
  value = try(module.prefix_list.*.prefix_list_id, "")
}

output "segment_id" {
  description = "ID of segment"
  value = try(module.segment.*.segment_id, "")
}

output "traffic_policy_id" {
  description = "ID of traffic policy"
  value = try(module.traffic_policy.*.traffic_policy_id, "")
}

output "traffic_rule_id" {
  description = "ID of traffic rule"
  value = try(module.traffic_rule.*.traffic_rule_id, "")
}

output "traffic_rule_list_id" {
  description = "ID of traffic rule list"
  value = try(module.traffic_rule_list.*.traffic_rule_list_id, "")
}