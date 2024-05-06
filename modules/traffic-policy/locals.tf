locals {
  filter_applications  = length(var.traffic_rule_data) > 0 ? [for application in var.traffic_rule_data : application.application if application.application != null] : []
  filter_src_rules     = length(var.traffic_rule_data) > 0 ? [for src_rule in var.traffic_rule_data : src_rule.src_prefix_list if src_rule.src_prefix_list != null] : []
  filter_dst_rules     = length(var.traffic_rule_data) > 0 ? [for dst_rule in var.traffic_rule_data : dst_rule.dst_prefix_list if dst_rule.dst_prefix_list != null] : []
  filter_rule_lists    = var.traffic_policy_data[*].rule_list
  filter_segments      = var.traffic_policy_data[*].segment

  filter_rules = flatten([
    for list in var.traffic_rule_list_data : [
      for rule in list.rules :
        rule
    ]
  ])

  filter_rule_list_data = flatten([
    for list in var.traffic_rule_list_data : {
        name         = list.name
        description  = list.description
        rules        = [for rule in list.rules : lookup(data.alkira_policy_rule.rule, rule, null)]
      }
  ])

  filter_from_groups = length(var.traffic_policy_data) > 0 ? flatten([
    for policy in var.traffic_policy_data : policy.from_groups != null ? [
      for group in policy.from_groups :
        group
    ] : []
  ]) : []

  filter_to_groups = length(var.traffic_policy_data) > 0 ? flatten([
    for policy in var.traffic_policy_data : policy.to_groups != null ? [
      for group in policy.to_groups :
        group
    ] : []
  ]) : []

  filter_from_connectors = length(var.traffic_policy_data) > 0 ? flatten([
    for policy in var.traffic_policy_data : policy.from_connectors != null ? [
      for connector in policy.from_connectors :
        connector
    ] : []
  ]) : []

  filter_to_connectors = length(var.traffic_policy_data) > 0 ? flatten([
    for policy in var.traffic_policy_data : policy.to_connectors != null ? [
      for connector in policy.to_connectors :
        connector
    ] : []
  ]) : []
}

locals {

  filter_rule_data = flatten([
    for rule in var.traffic_rule_data : {
        name            = rule.name
        rule_action     = rule.rule_action
        dscp            = rule.dscp
        protocol        = rule.protocol
        description     = rule.description
        src_ip          = rule.src_ip != null ? rule.src_ip : null
        dst_ip          = rule.dst_ip != null ? rule.dst_ip : null
        application     = rule.application != null ? lookup(data.alkira_internet_application.app, rule.application, null).id : null
        src_prefix_list = rule.src_prefix_list != null ? lookup(data.alkira_policy_prefix_list.src, rule.src_prefix_list, null).id : null
        dst_prefix_list = rule.dst_prefix_list != null ? lookup(data.alkira_policy_prefix_list.dst, rule.dst_prefix_list, null).id : null
        src_ports       = toset(rule.src_ports)
        dst_ports       = toset(rule.dst_ports)
        service_types   = rule.service_types
      }
  ])

  filter_policies = flatten([
    for policy in var.traffic_policy_data : {
      name                 = policy.name
      enabled              = policy.enabled
      description          = policy.description
      segment              = lookup(data.alkira_segment.segment, policy.segment, null).id
      rule_list            = lookup(data.alkira_policy_rule_list.rule_list, policy.rule_list, null).id

      # get aws implicit ids
      from_aws_connectors                 = length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_aws_vpc.from, connector, null).implicit_group_id if lookup(data.alkira_connector_aws_vpc.from, connector, null).implicit_group_id != null] : [],
      to_aws_connectors                   = length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_aws_vpc.to, connector, null).implicit_group_id if lookup(data.alkira_connector_aws_vpc.to, connector, null).implicit_group_id != null] : [],

      # get azure implicit ids
      from_azure_connectors               = length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_azure_vnet.from, connector, null).implicit_group_id if lookup(data.alkira_connector_azure_vnet.from, connector, null).implicit_group_id != null] : [],
      to_azure_connectors                 = length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_azure_vnet.to, connector, null).implicit_group_id if lookup(data.alkira_connector_azure_vnet.to, connector, null).implicit_group_id != null] : [],

      # get gcp implicit ids
      from_gcp_connectors                 = length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_gcp_vpc.from, connector, null).implicit_group_id if lookup(data.alkira_connector_gcp_vpc.from, connector, null).implicit_group_id != null] : [],
      to_gcp_connectors                   = length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_gcp_vpc.to, connector, null).implicit_group_id if lookup(data.alkira_connector_gcp_vpc.to, connector, null).implicit_group_id != null] : [],

      # get internet connector implicit ids
      from_internet_connectors            = length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_internet_exit.from, connector, null).implicit_group_id if lookup(data.alkira_connector_internet_exit.from, connector, null).implicit_group_id != null] : [],
      to_internet_connectors              = length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_internet_exit.to, connector, null).implicit_group_id if lookup(data.alkira_connector_internet_exit.to, connector, null).implicit_group_id != null] : [],

      # get ipsec connector implicit ids
      from_ipsec_connectors               = length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_ipsec.from, connector, null).implicit_group_id if lookup(data.alkira_connector_ipsec.from, connector, null).implicit_group_id != null] : [],
      to_ipsec_connectors                 = length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_ipsec.to, connector, null).implicit_group_id if lookup(data.alkira_connector_ipsec.to, connector, null).implicit_group_id != null] : [],

      # get oci implicit ids
      from_oci_connectors                 = length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_oci_vcn.from, connector, null).implicit_group_id if lookup(data.alkira_connector_oci_vcn.from, connector, null).implicit_group_id != null] : [],
      to_oci_connectors                   = length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_oci_vcn.to, connector, null).implicit_group_id if lookup(data.alkira_connector_oci_vcn.to, connector, null).implicit_group_id != null] : [],

      # get cisco sdwan implicit ids
      from_cisco_sdwan_connectors         = length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_cisco_sdwan.from, connector, null).implicit_group_id if lookup(data.alkira_connector_cisco_sdwan.from, connector, null).implicit_group_id != null] : [],
      to_cisco_sdwan_connectors           = length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_cisco_sdwan.to, connector, null).implicit_group_id if lookup(data.alkira_connector_cisco_sdwan.to, connector, null).implicit_group_id != null] : [],

      # get aruba edge implicit ids
      from_aruba_edge_connectors          = length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_aruba_edge.from, connector, null).implicit_group_id if lookup(data.alkira_connector_aruba_edge.from, connector, null).implicit_group_id != null] : [],
      to_aruba_edge_connectors            = length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_aruba_edge.to, connector, null).implicit_group_id if lookup(data.alkira_connector_aruba_edge.to, connector, null).implicit_group_id != null] : [],

      # get azure expressroute implicit ids
      from_azure_expressroute_connectors  = length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_azure_expressroute.from, connector, null).implicit_group_id if lookup(data.alkira_connector_azure_expressroute.from, connector, null).implicit_group_id != null] : [],
      to_azure_expressroute_connectors    = length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_azure_expressroute.to, connector, null).implicit_group_id if lookup(data.alkira_connector_azure_expressroute.to, connector, null).implicit_group_id != null] : [],

      # get vmware sdwan implicit ids
      from_vmware_sdwan_connectors        = length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_vmware_sdwan.from, connector, null).implicit_group_id if lookup(data.alkira_connector_vmware_sdwan.from, connector, null).implicit_group_id != null] : [],
      to_vmware_sdwan_connectors          = length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_vmware_sdwan.to, connector, null).implicit_group_id if lookup(data.alkira_connector_vmware_sdwan.to, connector, null).implicit_group_id != null] : [],

      # get standard group ids
      from_groups                         = length(policy.from_groups) > 0 ? [for group in policy.from_groups : lookup(data.alkira_group.from, group, null).id if lookup(data.alkira_group.from, group, null).id != null] : [],
      to_groups                           = length(policy.to_groups) > 0 ? [for group in policy.to_groups : lookup(data.alkira_group.to, group, null).id if lookup(data.alkira_group.to, group, null).id != null] : [],

      # concat id types in single list for 'two' and 'from'
      from_group_list      = distinct(concat(
        length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_aws_vpc.from, connector, null).implicit_group_id if lookup(data.alkira_connector_aws_vpc.from, connector, null).implicit_group_id != null] : [],
        length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_azure_vnet.from, connector, null).implicit_group_id if lookup(data.alkira_connector_azure_vnet.from, connector, null).implicit_group_id != null] : [],
        length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_gcp_vpc.from, connector, null).implicit_group_id if lookup(data.alkira_connector_gcp_vpc.from, connector, null).implicit_group_id != null] : [],
        length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_oci_vcn.from, connector, null).implicit_group_id if lookup(data.alkira_connector_oci_vcn.from, connector, null).implicit_group_id != null] : [],
        length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_cisco_sdwan.from, connector, null).implicit_group_id if lookup(data.alkira_connector_cisco_sdwan.from, connector, null).implicit_group_id != null] : [],
        length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_aruba_edge.from, connector, null).implicit_group_id if lookup(data.alkira_connector_aruba_edge.from, connector, null).implicit_group_id != null] : [],
        length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_vmware_sdwan.from, connector, null).implicit_group_id if lookup(data.alkira_connector_vmware_sdwan.from, connector, null).implicit_group_id != null] : [],
        length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_internet_exit.from, connector, null).implicit_group_id if lookup(data.alkira_connector_internet_exit.from, connector, null).implicit_group_id != null] : [],
        length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_ipsec.from, connector, null).implicit_group_id if lookup(data.alkira_connector_ipsec.from, connector, null).implicit_group_id != null] : [],
        length(policy.from_connectors) > 0 ? [for connector in policy.from_connectors : lookup(data.alkira_connector_azure_expressroute.from, connector, null).implicit_group_id if lookup(data.alkira_connector_azure_expressroute.from, connector, null).implicit_group_id != null] : [],
        length(policy.from_groups) > 0 ? [for group in policy.from_groups : lookup(data.alkira_group.from, group, null).id if lookup(data.alkira_group.from, group, null).id != null] : []
      )),
      to_group_list        = distinct(concat(
        length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_aws_vpc.to, connector, null).implicit_group_id if lookup(data.alkira_connector_aws_vpc.to, connector, null).implicit_group_id != null] : [],
        length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_azure_vnet.to, connector, null).implicit_group_id if lookup(data.alkira_connector_azure_vnet.to, connector, null).implicit_group_id != null] : [],
        length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_gcp_vpc.to, connector, null).implicit_group_id if lookup(data.alkira_connector_gcp_vpc.to, connector, null).implicit_group_id != null] : [],
        length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_oci_vcn.to, connector, null).implicit_group_id if lookup(data.alkira_connector_oci_vcn.to, connector, null).implicit_group_id != null] : [],
        length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_cisco_sdwan.to, connector, null).implicit_group_id if lookup(data.alkira_connector_cisco_sdwan.to, connector, null).implicit_group_id != null] : [],
        length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_aruba_edge.to, connector, null).implicit_group_id if lookup(data.alkira_connector_aruba_edge.to, connector, null).implicit_group_id != null] : [],
        length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_vmware_sdwan.to, connector, null).implicit_group_id if lookup(data.alkira_connector_vmware_sdwan.to, connector, null).implicit_group_id != null] : [],
        length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_internet_exit.to, connector, null).implicit_group_id if lookup(data.alkira_connector_internet_exit.to, connector, null).implicit_group_id != null] : [],
        length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_ipsec.to, connector, null).implicit_group_id if lookup(data.alkira_connector_ipsec.to, connector, null).implicit_group_id != null] : [],
        length(policy.to_connectors) > 0 ? [for connector in policy.to_connectors : lookup(data.alkira_connector_azure_expressroute.to, connector, null).implicit_group_id if lookup(data.alkira_connector_azure_expressroute.to, connector, null).implicit_group_id != null] : [],
        length(policy.to_groups) > 0 ? [for group in policy.to_groups : lookup(data.alkira_group.to, group, null).id if lookup(data.alkira_group.to, group, null).id != null] : []
      ))
    }
  ])
}