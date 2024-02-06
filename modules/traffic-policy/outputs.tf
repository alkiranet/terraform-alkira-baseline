output "traffic_policy_id" {
  description = "ID of traffic policy"
  value = {
    for k, v in alkira_policy.policy : k => v.id
  }
}

output "traffic_rule_id" {
  description = "ID of traffic rule"
  value = {
    for k, v in alkira_policy_rule.rule : k => v.id
  }
}

output "traffic_rule_list_id" {
  description = "ID of traffic rule list"
  value = {
    for k, v in alkira_policy_rule_list.rule_list : k => v.id
  }
}