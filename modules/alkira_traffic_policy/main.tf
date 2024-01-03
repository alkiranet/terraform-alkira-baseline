locals {

# filter 'FROM' and 'TO' prefix lists
filter_src_rules = var.traffic_rule_data[*].src_prefix_list
filter_dst_rules = var.traffic_rule_data[*].dst_prefix_list

}

data "alkira_policy_prefix_list" "src" {

  for_each = toset(local.filter_src_rules)
  name     = each.value

}

data "alkira_policy_prefix_list" "dst" {

  for_each = toset(local.filter_dst_rules)
  name     = each.value

}

/*
alkira_policy_rule
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy_rule
*/
locals {

  filter_rule_data = flatten([
    for rule in var.traffic_rule_data : {
        name            = rule.name
        rule_action     = rule.rule_action
        dscp            = rule.dscp
        protocol        = rule.protocol
        description     = rule.description
        src_prefix_list = lookup(data.alkira_policy_prefix_list.src, rule.src_prefix_list, null).id
        dst_prefix_list = lookup(data.alkira_policy_prefix_list.dst, rule.dst_prefix_list, null).id
        src_ports       = toset(rule.src_ports)
        dst_ports       = toset(rule.dst_ports)
        service_types   = rule.service_types
      }
  ])

}

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
  src_prefix_list_id        = each.value.src_prefix_list
  dst_prefix_list_id        = each.value.dst_prefix_list
  rule_action_service_types = each.value.service_types

}

locals {

  filter_rules = flatten([
    for list in var.traffic_rule_list_data : [
      for rule in list.rules :
        rule
    ]
  ])

}

data "alkira_policy_rule" "rule" {
  for_each = toset(local.filter_rules)

  name = each.value

}

/*
alkira_policy_rule_list
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy_rule_list
*/
locals {

   filter_rule_list_data = flatten([
    for list in var.traffic_rule_list_data : {
        name         = list.name
        description  = list.description
        rules        = [for rule in list.rules : lookup(data.alkira_policy_rule.rule, rule, null)]
      }
  ])

}

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

locals {

  # filter 'FROM' and 'TO' group data
  filter_from_groups = flatten([
    for policy in var.traffic_policy_data : [
      for group in policy.from_groups : 
        group
    ]
  ])

  filter_to_groups = flatten([
    for policy in var.traffic_policy_data : [
      for group in policy.to_groups : 
        group
    ]
  ])

}
data "alkira_group" "from_group" {

  for_each = {
    for k, v in toset(local.filter_from_groups) : k => v
  }

  name = each.key

}

data "alkira_group" "to_group" {

  for_each = {
    for k, v in toset(local.filter_to_groups) : k => v
  }

  name = each.key

}

locals {

  # filter 'segment' data
  filter_segments   = var.traffic_policy_data[*].segment

}

data "alkira_segment" "segment" {

  for_each = toset(local.filter_segments)

  name = each.value

}

locals {

  # Filter rule lists
  filter_rule_lists = var.traffic_policy_data[*].rule_list

}

data "alkira_policy_rule_list" "rule_list" {

  for_each = toset(local.filter_rule_lists)

  name = each.value

}

/*
alkira_policy
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy
*/
locals {

  filter_policies = flatten([
    for policy in var.traffic_policy_data : {
        name         = policy.name
        enabled      = policy.enabled
        description  = policy.description
        segment      = lookup(data.alkira_segment.segment, policy.segment, null).id
        rule_list    = lookup(data.alkira_policy_rule_list.rule_list, policy.rule_list, null).id
        from_groups  = [for group in policy.from_groups : lookup(data.alkira_group.from_group, group, null).id]
        to_groups    = [for group in policy.to_groups : lookup(data.alkira_group.to_group, group, null).id]
      }
  ])

}

resource "alkira_policy" "policy" {

  for_each = {
    for o in local.filter_policies : o.name => o
  }

  name         = each.value.name
  description  = each.value.description
  enabled      = each.value.enabled
  from_groups  = each.value.from_groups
  to_groups    = each.value.to_groups
  rule_list_id = each.value.rule_list
  segment_ids  = [each.value.segment]

}