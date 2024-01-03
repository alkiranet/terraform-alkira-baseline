# Alkira Baseline - Terraform Module
This module creates various resources in _Alkira_ from **.yaml** files.

## Basic Usage
Define the path to your **.yaml** configuration file in the module.

```hcl
module "baseline" {
  source = "alkiranet/baseline/alkira"
  
  # path to config
  config_files = "./config/network.yaml"
  
}
```

### Configuration Example
The module will automatically create resources if they are present in the **.yaml** configuration with the proper _resource keys_ defined.

**network.yaml**
```yaml
---
segment:
  - name: 'business'
    cidrs:
      - '10.100.1.0/24'

group:
  - name: 'cloud'
    description: 'Cloud Workloads'

  - name: 'www'
    description: 'Internet Egress'

billing_tag:
  - name: 'shared-services'
    description: 'MCN Shared Services'

connector_internet:
  - name: 'www-east'
    description: 'MCN Internet East'
    cxp: 'US-EAST-2'
    group: 'www'
    segment: 'business'
...
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.1 |
| <a name="requirement_alkira"></a> [alkira](#requirement\_alkira) | >= 1.1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_billing_tag"></a> [billing\_tag](#module\_billing\_tag) | ./modules/alkira_base | n/a |
| <a name="module_connector_internet"></a> [connector\_internet](#module\_connector\_internet) | ./modules/connector_internet | n/a |
| <a name="module_global_cidr_list"></a> [global\_cidr\_list](#module\_global\_cidr\_list) | ./modules/alkira_base | n/a |
| <a name="module_group"></a> [group](#module\_group) | ./modules/alkira_base | n/a |
| <a name="module_prefix_list"></a> [prefix\_list](#module\_prefix\_list) | ./modules/alkira_base | n/a |
| <a name="module_segment"></a> [segment](#module\_segment) | ./modules/alkira_base | n/a |
| <a name="module_traffic_policy"></a> [traffic\_policy](#module\_traffic\_policy) | ./modules/alkira_traffic_policy | n/a |
| <a name="module_traffic_rule"></a> [traffic\_rule](#module\_traffic\_rule) | ./modules/alkira_traffic_policy | n/a |
| <a name="module_traffic_rule_list"></a> [traffic\_rule\_list](#module\_traffic\_rule\_list) | ./modules/alkira_traffic_policy | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_file"></a> [config\_file](#input\_config\_file) | Path to .yaml files | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_tag_id"></a> [billing\_tag\_id](#output\_billing\_tag\_id) | ID of billing tag |
| <a name="output_connector_internet_id"></a> [connector\_internet\_id](#output\_connector\_internet\_id) | ID of internet exit connector |
| <a name="output_connector_internet_implicit_group_id"></a> [connector\_internet\_implicit\_group\_id](#output\_connector\_internet\_implicit\_group\_id) | Implicit group ID of internet exit connector |
| <a name="output_global_cidr_list_id"></a> [global\_cidr\_list\_id](#output\_global\_cidr\_list\_id) | ID of global cidr list |
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | ID of group |
| <a name="output_prefix_list_id"></a> [prefix\_list\_id](#output\_prefix\_list\_id) | ID of prefix list |
| <a name="output_segment_id"></a> [segment\_id](#output\_segment\_id) | ID of segment |
| <a name="output_traffic_policy_id"></a> [traffic\_policy\_id](#output\_traffic\_policy\_id) | ID of traffic policy |
| <a name="output_traffic_rule_id"></a> [traffic\_rule\_id](#output\_traffic\_rule\_id) | ID of traffic rule |
| <a name="output_traffic_rule_list_id"></a> [traffic\_rule\_list\_id](#output\_traffic\_rule\_list\_id) | ID of traffic rule list |
<!-- END_TF_DOCS -->