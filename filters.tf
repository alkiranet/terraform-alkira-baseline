locals {

  # parse yaml configuration
  config_file              = var.config_file
  config_file_content      = fileexists(local.config_file) ? file(local.config_file) : "NoConfigurationFound: true"
  config                   = yamldecode(local.config_file_content)

  # connector resource keys
  connector_aws_vpc        = contains(keys(local.config), "connector_aws_vpc")
  connector_azure_vnet     = contains(keys(local.config), "connector_azure_vnet")
  connector_cisco_sdwan    = contains(keys(local.config), "connector_cisco_sdwan")
  connector_gcp_vpc        = contains(keys(local.config), "connector_gcp_vpc")
  connector_internet       = contains(keys(local.config), "connector_internet")
  connector_vmware_sdwan   = contains(keys(local.config), "connector_vmware_sdwan")

  # service resource keys
  service_fortinet         = contains(keys(local.config), "service_fortinet")
  service_pan              = contains(keys(local.config), "service_pan")

  # base resource keys
  billing_tag              = contains(keys(local.config), "billing_tag")
  group                    = contains(keys(local.config), "group")
  segment                  = contains(keys(local.config), "segment")

  # list keys
  prefix_list              = contains(keys(local.config), "prefix_list")
  global_cidr_list         = contains(keys(local.config), "global_cidr_list") 

  # traffic policy keys
  traffic_policy           = contains(keys(local.config), "traffic_policy")
  traffic_rule_list        = contains(keys(local.config), "traffic_rule_list")
  traffic_rule             = contains(keys(local.config), "traffic_rule")

}