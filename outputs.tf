output "alkira_connector_aws_id" {
  description = "ID of AWS connector"
  value = try(module.connector_aws_vpc.*.alkira_connector_aws_id, "")
}

output "alkira_connector_aws_implicit_group_id" {
  description = "Implicit group ID of AWS connector"
  value = try(module.connector_aws_vpc.*.alkira_connector_aws_implicit_group_id, "")
}

output "alkira_connector_azure_id" {
  description  = "ID of Azure connector"
  value        = try(module.connector_azure_vnet.*.alkira_connector_azure_id, "")
}

output "alkira_connector_azure_implicit_group_id" {
  description  = "Implicit group ID of Azure connector"
  value        = try(module.connector_azure_vnet.*.alkira_connector_azure_implicit_group_id, "")
}

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

output "connector_vmware_sdwan_id" {
  description = "ID of VMware SDWAN connector"
  value = try(module.connector_vmware_sdwan.*.connector_vmware_sdwan_id, "")
}

output "connector_vmware_sdwan_implicit_group_id" {
  description = "Implicit group ID of VMware SDWAN connector"
  value = try(module.connector_vmware_sdwan.*.connector_vmware_sdwan_implicit_group_id, "")
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

output "service_fortinet_id" {
  description = "ID of Fortinet service"
  value = try(module.service_fortinet.*.service_fortinet_id, "")
}

output "service_pan_id" {
  description = "ID of PAN service"
  value = try(module.service_pan.*.service_pan_id, "")
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