module "billing_tag" {
  source = "./modules/base-network"

  # do keys exist?
  count = local.billing_tag ? 1 : 0

  # set bool
  billing_tag       = local.billing_tag ? true : false

  # pass data
  billing_tag_data  = local.config["billing_tag"]

}

module "connector_azure_vnet" {
  source = "./modules/connector-azure-vnet"

  # do keys exist?
  count = local.connector_azure_vnet ? 1 : 0

  # set bool
  azure_vnet        = local.connector_azure_vnet ? true : false

  # pass data
  azure_vnet_data  = local.config["connector_azure_vnet"]

  depends_on        = [module.billing_tag, module.group, module.segment]

}

module "connector_cisco_sdwan" {
  source = "./modules/connector-cisco-sdwan"

  # do keys exist?
  count = local.connector_cisco_sdwan ? 1 : 0

  # set bool
  cisco_sdwan       = local.connector_cisco_sdwan ? true : false

  # pass data
  cisco_sdwan_data  = local.config["connector_cisco_sdwan"]

  depends_on        = [module.billing_tag, module.group, module.segment]

}

module "connector_internet" {
  source = "./modules/connector-internet-exit"

  # do keys exist?
  count = local.connector_internet ? 1 : 0

  # set bool
  connector_internet       = local.connector_internet ? true : false

  # pass data
  connector_internet_data  = local.config["connector_internet"]

  depends_on               = [module.billing_tag, module.group, module.segment]

}

module "connector_vmware_sdwan" {
  source = "./modules/connector-vmware-sdwan"

  # do keys exist?
  count = local.connector_vmware_sdwan ? 1 : 0

  # set bool
  vmware_sdwan       = local.connector_vmware_sdwan ? true : false

  # pass data
  vmware_sdwan_data  = local.config["connector_vmware_sdwan"]

  depends_on         = [module.billing_tag, module.group, module.segment]

}

module "group" {
  source = "./modules/base-network"

  # do keys exist?
  count = local.group ? 1 : 0

  # set bool
  group       = local.group ? true : false

  # pass data
  group_data  = local.config["group"]

}

module "prefix_list" {
  source = "./modules/base-network"

  # do keys exist?
  count = local.prefix_list ? 1 : 0

  # set bool
  prefix_list       = local.prefix_list ? true : false

  # pass data
  prefix_list_data  = local.config["prefix_list"]

}

module "global_cidr_list" {
  source = "./modules/base-network"

  # do keys exist?
  count = local.global_cidr_list ? 1 : 0

  # set bool
  global_cidr_list       = local.global_cidr_list ? true : false

  # pass data
  global_cidr_list_data  = local.config["global_cidr_list"]

}

module "segment" {
  source = "./modules/base-network"

  # do keys exist?
  count = local.segment ? 1 : 0

  # set bool
  segment       = local.segment ? true : false

  # pass data
  segment_data  = local.config["segment"]

}

module "service_fortinet" {
  source = "./modules/service-fortinet"

  # do keys exist?
  count = local.service_fortinet ? 1 : 0

  # set bool
  service_fortinet       = local.service_fortinet ? true : false

  # pass data
  fortinet_service_data  = local.config["service_fortinet"]

  depends_on             = [module.billing_tag, module.group, module.segment]

}

module "service_pan" {
  source = "./modules/service-pan"

  # do keys exist?
  count = local.service_pan ? 1 : 0

  # set bool
  service_pan       = local.service_pan ? true : false

  # pass data
  pan_service_data  = local.config["service_pan"]

  depends_on        = [module.billing_tag, module.group, module.segment]

}

module "traffic_policy" {
  source = "./modules/traffic-policy"

  # do keys exist?
  count = local.traffic_policy ? 1 : 0

  # set bool
  traffic_policy       = local.traffic_policy ? true : false

  # pass data
  traffic_policy_data  = local.config["traffic_policy"]

  depends_on           = [module.group, module.segment, module.traffic_rule_list]

}

module "traffic_rule" {
  source = "./modules/traffic-policy"

  # do keys exist?
  count = local.traffic_rule ? 1 : 0

  # set bool
  traffic_rule       = local.traffic_rule ? true : false

  # pass data
  traffic_rule_data  = local.config["traffic_rule"]

  depends_on = [module.prefix_list]

}

module "traffic_rule_list" {
  source = "./modules/traffic-policy"

  # do keys exist?
  count = local.traffic_rule_list ? 1 : 0

  # set bool
  traffic_rule_list       = local.traffic_rule_list ? true : false

  # pass data
  traffic_rule_list_data  = local.config["traffic_rule_list"]

  depends_on = [module.traffic_rule]

}