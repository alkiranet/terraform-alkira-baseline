# Alkira Baseline - Terraform Module
This module makes it easy to provision _shared_ resources in Alkira.

## What it does
Creates _shared_ resources in _Alkira_ from **.yml** templates.

### Basic Usage
Add the required line items with **= true**. Then create the corresponding **.yml** files inside the config folder and populate the desired values. An example project can be found [here.](./examples)

### Flag infrastructure to provision
```hcl
module "baseline" {
  source = "alkiranet/baseline/alkira"

  # Provision billing tags, groups, and segments
  create_billing_tags    = true
  create_groups          = true
  create_segments        = true

}
```

### Define configuration in .yml files
The **.yml** template files can be found [here.](./templates) 

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
| [alkira_segment.segment](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/segment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_billing_tags"></a> [create\_billing\_tags](#input\_create\_billing\_tags) | Controls if billing tags are created | `bool` | `false` | no |
| <a name="input_create_groups"></a> [create\_groups](#input\_create\_groups) | Controls if groups are created | `bool` | `false` | no |
| <a name="input_create_segments"></a> [create\_segments](#input\_create\_segments) | Controls if segments are created | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_tag_id"></a> [billing\_tag\_id](#output\_billing\_tag\_id) | Alkira billing tag ID |
| <a name="output_connector_group_id"></a> [connector\_group\_id](#output\_connector\_group\_id) | Alkira connector group ID |
| <a name="output_segment_id"></a> [segment\_id](#output\_segment\_id) | Alkira segment ID |
<!-- END_TF_DOCS -->