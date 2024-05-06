/*
alkira_policy_rule
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy_rule
*/
resource "alkira_policy_rule" "rule" {

  for_each = {
    for o in local.filter_rule_data : o.name => o
    if var.traffic_rule == true
  }

  name                      = each.value.name
  description               = each.value.description
  rule_action               = each.value.rule_action
  dscp                      = each.value.dscp
  protocol                  = each.value.protocol
  src_ports                 = each.value.src_ports
  dst_ports                 = each.value.dst_ports
  src_ip                    = each.value.src_ip
  dst_ip                    = each.value.dst_ip
  src_prefix_list_id        = each.value.src_prefix_list
  dst_prefix_list_id        = each.value.dst_prefix_list
  internet_application_id   = each.value.application
  rule_action_service_types = each.value.service_types

}

/*
alkira_policy_rule_list
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy_rule_list
*/
resource "alkira_policy_rule_list" "rule_list" {

  for_each = {
    for o in local.filter_rule_list_data : o.name => o
  }

  name        = each.value.name
  description = each.value.description

  dynamic "rules" {
    for_each = each.value.rules[*].id

    content {
      priority = format("%d", rules.key + 1)
      rule_id  = rules.value
    }

  }

}

/*
alkira_policy
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy
*/
resource "alkira_policy" "policy" {

  for_each = {
    for o in local.filter_policies : o.name => o
  }

  name         = each.value.name
  description  = each.value.description
  enabled      = each.value.enabled
  from_groups  = each.value.from_group_list
  to_groups    = each.value.to_group_list
  rule_list_id = each.value.rule_list
  segment_ids  = [each.value.segment]

}