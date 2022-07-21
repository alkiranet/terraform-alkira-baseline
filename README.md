# Alkira Baseline - Terraform Module
This module creates _shared_ resources in _Alkira_ from **.yml** templates.

## Basic Usage
First, define the path to your **.yml** configuration files. Then, add the required line items with **= true**. Use [these blank templates](https://github.com/alkiranet/terraform-alkira-baseline/templates) as a starting point, and don't change the names. Example projects can be found [here](./examples).

```hcl
module "baseline" {
  source = "alkiranet/baseline/alkira"

  create_billing_tags    = true
  create_groups          = true
  create_segments        = true

}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alkira"></a> [alkira](#requirement\_alkira) | >= 0.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alkira"></a> [alkira](#provider\_alkira) | >= 0.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alkira_billing_tag.tag](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/billing_tag) | resource |
| [alkira_group_connector.group](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/group_connector) | resource |
| [alkira_group_user.group](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/group_user) | resource |
| [alkira_policy_prefix_list.list](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy_prefix_list) | resource |
| [alkira_policy_rule.rule](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy_rule) | resource |
| [alkira_segment.segment](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/segment) | resource |
| [alkira_policy_prefix_list.dst_prefix_list](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/policy_prefix_list) | data source |
| [alkira_policy_prefix_list.src_prefix_list](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/policy_prefix_list) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_path"></a> [config\_path](#input\_config\_path) | Path to .yml files | `string` | `"./config/"` | no |
| <a name="input_create_groups"></a> [create\_groups](#input\_create\_groups) | Controls if groups are created | `bool` | `false` | no |
| <a name="input_create_lists"></a> [create\_lists](#input\_create\_lists) | Controls if lists are created | `bool` | `false` | no |
| <a name="input_create_rules"></a> [create\_rules](#input\_create\_rules) | Controls if rules are created | `bool` | `false` | no |
| <a name="input_create_segments"></a> [create\_segments](#input\_create\_segments) | Controls if segments are created | `bool` | `false` | no |
| <a name="input_create_tags"></a> [create\_tags](#input\_create\_tags) | Controls if tags are created | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_tag_id"></a> [billing\_tag\_id](#output\_billing\_tag\_id) | Alkira billing tag ID |
| <a name="output_connector_group_id"></a> [connector\_group\_id](#output\_connector\_group\_id) | Alkira connector group ID |
| <a name="output_prefix_list_id"></a> [prefix\_list\_id](#output\_prefix\_list\_id) | Alkira prefix-list ID |
| <a name="output_segment_id"></a> [segment\_id](#output\_segment\_id) | Alkira segment ID |
| <a name="output_traffic_rule_id"></a> [traffic\_rule\_id](#output\_traffic\_rule\_id) | Alkira traffic rule ID |
| <a name="output_user_group_id"></a> [user\_group\_id](#output\_user\_group\_id) | Alkira user group ID |
<!-- END_TF_DOCS -->