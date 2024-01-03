module "billing_tag" {
  source = "./modules/alkira_base"

  # do keys exist?
  count = local.billing_tag ? 1 : 0

  # set bool
  billing_tag       = local.billing_tag ? true : false

  # pass data
  billing_tag_data  = local.config["billing_tag"]

}

module "connector_internet" {
  source = "./modules/connector_internet"

  # do keys exist?
  count = local.connector_internet ? 1 : 0

  # set bool
  connector_internet       = local.connector_internet ? true : false

  # pass data
  connector_internet_data  = local.config["connector_internet"]

  depends_on               = [module.billing_tag, module.group, module.segment]

}

module "group" {
  source = "./modules/alkira_base"

  # do keys exist?
  count = local.group ? 1 : 0

  # set bool
  group       = local.group ? true : false

  # pass data
  group_data  = local.config["group"]

}

module "prefix_list" {
  source = "./modules/alkira_base"

  # do keys exist?
  count = local.prefix_list ? 1 : 0

  # set bool
  prefix_list       = local.prefix_list ? true : false

  # pass data
  prefix_list_data  = local.config["prefix_list"]

}

module "global_cidr_list" {
  source = "./modules/alkira_base"

  # do keys exist?
  count = local.global_cidr_list ? 1 : 0

  # set bool
  global_cidr_list       = local.global_cidr_list ? true : false

  # pass data
  global_cidr_list_data  = local.config["global_cidr_list"]

}

module "segment" {
  source = "./modules/alkira_base"

  # do keys exist?
  count = local.segment ? 1 : 0

  # set bool
  segment       = local.segment ? true : false

  # pass data
  segment_data  = local.config["segment"]

}

module "traffic_policy" {
  source = "./modules/alkira_traffic_policy"

  # do keys exist?
  count = local.traffic_policy ? 1 : 0

  # set bool
  traffic_policy       = local.traffic_policy ? true : false

  # pass data
  traffic_policy_data  = local.config["traffic_policy"]

  depends_on           = [module.group, module.segment, module.traffic_rule_list]

}

module "traffic_rule" {
  source = "./modules/alkira_traffic_policy"

  # do keys exist?
  count = local.traffic_rule ? 1 : 0

  # set bool
  traffic_rule       = local.traffic_rule ? true : false

  # pass data
  traffic_rule_data  = local.config["traffic_rule"]

  depends_on = [module.prefix_list]

}

module "traffic_rule_list" {
  source = "./modules/alkira_traffic_policy"

  # do keys exist?
  count = local.traffic_rule_list ? 1 : 0

  # set bool
  traffic_rule_list       = local.traffic_rule_list ? true : false

  # pass data
  traffic_rule_list_data  = local.config["traffic_rule_list"]

  depends_on = [module.traffic_rule]

}