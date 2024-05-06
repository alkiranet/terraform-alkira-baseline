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
| <a name="requirement_alkira"></a> [alkira](#requirement\_alkira) | >= 1.2.5 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_billing_tag"></a> [billing\_tag](#module\_billing\_tag) | ./modules/base-network | n/a |
| <a name="module_connector_aws_vpc"></a> [connector\_aws\_vpc](#module\_connector\_aws\_vpc) | ./modules/connector-aws-vpc | n/a |
| <a name="module_connector_azure_vnet"></a> [connector\_azure\_vnet](#module\_connector\_azure\_vnet) | ./modules/connector-azure-vnet | n/a |
| <a name="module_connector_cisco_sdwan"></a> [connector\_cisco\_sdwan](#module\_connector\_cisco\_sdwan) | ./modules/connector-cisco-sdwan | n/a |
| <a name="module_connector_gcp_vpc"></a> [connector\_gcp\_vpc](#module\_connector\_gcp\_vpc) | ./modules/connector-gcp-vpc | n/a |
| <a name="module_connector_internet"></a> [connector\_internet](#module\_connector\_internet) | ./modules/connector-internet-exit | n/a |
| <a name="module_connector_ipsec"></a> [connector\_ipsec](#module\_connector\_ipsec) | ./modules/connector-ipsec | n/a |
| <a name="module_connector_oci_vcn"></a> [connector\_oci\_vcn](#module\_connector\_oci\_vcn) | ./modules/connector-oci-vcn | n/a |
| <a name="module_connector_vmware_sdwan"></a> [connector\_vmware\_sdwan](#module\_connector\_vmware\_sdwan) | ./modules/connector-vmware-sdwan | n/a |
| <a name="module_global_cidr_list"></a> [global\_cidr\_list](#module\_global\_cidr\_list) | ./modules/base-network | n/a |
| <a name="module_group"></a> [group](#module\_group) | ./modules/base-network | n/a |
| <a name="module_internet_application"></a> [internet\_application](#module\_internet\_application) | ./modules/internet-application | n/a |
| <a name="module_prefix_list"></a> [prefix\_list](#module\_prefix\_list) | ./modules/base-network | n/a |
| <a name="module_segment"></a> [segment](#module\_segment) | ./modules/base-network | n/a |
| <a name="module_service_fortinet"></a> [service\_fortinet](#module\_service\_fortinet) | ./modules/service-fortinet | n/a |
| <a name="module_service_pan"></a> [service\_pan](#module\_service\_pan) | ./modules/service-pan | n/a |
| <a name="module_traffic_policy"></a> [traffic\_policy](#module\_traffic\_policy) | ./modules/traffic-policy | n/a |
| <a name="module_traffic_rule"></a> [traffic\_rule](#module\_traffic\_rule) | ./modules/traffic-policy | n/a |
| <a name="module_traffic_rule_list"></a> [traffic\_rule\_list](#module\_traffic\_rule\_list) | ./modules/traffic-policy | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_file"></a> [config\_file](#input\_config\_file) | Path to .yaml files | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alkira_connector_aws_id"></a> [alkira\_connector\_aws\_id](#output\_alkira\_connector\_aws\_id) | ID of AWS connector |
| <a name="output_alkira_connector_aws_implicit_group_id"></a> [alkira\_connector\_aws\_implicit\_group\_id](#output\_alkira\_connector\_aws\_implicit\_group\_id) | Implicit group ID of AWS connector |
| <a name="output_alkira_connector_azure_id"></a> [alkira\_connector\_azure\_id](#output\_alkira\_connector\_azure\_id) | ID of Azure connector |
| <a name="output_alkira_connector_azure_implicit_group_id"></a> [alkira\_connector\_azure\_implicit\_group\_id](#output\_alkira\_connector\_azure\_implicit\_group\_id) | Implicit group ID of Azure connector |
| <a name="output_alkira_connector_gcp_id"></a> [alkira\_connector\_gcp\_id](#output\_alkira\_connector\_gcp\_id) | ID of GCP connector |
| <a name="output_alkira_connector_gcp_implicit_group_id"></a> [alkira\_connector\_gcp\_implicit\_group\_id](#output\_alkira\_connector\_gcp\_implicit\_group\_id) | Implicit group ID of GCP connector |
| <a name="output_billing_tag_id"></a> [billing\_tag\_id](#output\_billing\_tag\_id) | ID of billing tag |
| <a name="output_connector_cisco_sdwan_id"></a> [connector\_cisco\_sdwan\_id](#output\_connector\_cisco\_sdwan\_id) | ID of Cisco SDWAN connector |
| <a name="output_connector_cisco_sdwan_implicit_group_id"></a> [connector\_cisco\_sdwan\_implicit\_group\_id](#output\_connector\_cisco\_sdwan\_implicit\_group\_id) | Implicit group ID of Cisco SDWAN connector |
| <a name="output_connector_internet_id"></a> [connector\_internet\_id](#output\_connector\_internet\_id) | ID of internet exit connector |
| <a name="output_connector_internet_implicit_group_id"></a> [connector\_internet\_implicit\_group\_id](#output\_connector\_internet\_implicit\_group\_id) | Implicit group ID of internet connector |
| <a name="output_connector_ipsec_id"></a> [connector\_ipsec\_id](#output\_connector\_ipsec\_id) | ID of IPSec connector |
| <a name="output_connector_ipsec_implicit_group_id"></a> [connector\_ipsec\_implicit\_group\_id](#output\_connector\_ipsec\_implicit\_group\_id) | Implicit group ID of internet connector |
| <a name="output_connector_oci_id"></a> [connector\_oci\_id](#output\_connector\_oci\_id) | ID of OCI connector |
| <a name="output_connector_oci_implicit_group_id"></a> [connector\_oci\_implicit\_group\_id](#output\_connector\_oci\_implicit\_group\_id) | Implicit group ID of OCI connector |
| <a name="output_connector_vmware_sdwan_id"></a> [connector\_vmware\_sdwan\_id](#output\_connector\_vmware\_sdwan\_id) | ID of VMware SDWAN connector |
| <a name="output_connector_vmware_sdwan_implicit_group_id"></a> [connector\_vmware\_sdwan\_implicit\_group\_id](#output\_connector\_vmware\_sdwan\_implicit\_group\_id) | Implicit group ID of VMware SDWAN connector |
| <a name="output_global_cidr_list_id"></a> [global\_cidr\_list\_id](#output\_global\_cidr\_list\_id) | ID of global cidr list |
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | ID of group |
| <a name="output_internet_application_group_id"></a> [internet\_application\_group\_id](#output\_internet\_application\_group\_id) | Group ID of Internet Application |
| <a name="output_internet_application_id"></a> [internet\_application\_id](#output\_internet\_application\_id) | ID of Internet Application |
| <a name="output_prefix_list_id"></a> [prefix\_list\_id](#output\_prefix\_list\_id) | ID of prefix list |
| <a name="output_segment_id"></a> [segment\_id](#output\_segment\_id) | ID of segment |
| <a name="output_service_fortinet_id"></a> [service\_fortinet\_id](#output\_service\_fortinet\_id) | ID of Fortinet service |
| <a name="output_service_pan_id"></a> [service\_pan\_id](#output\_service\_pan\_id) | ID of PAN service |
| <a name="output_traffic_policy_id"></a> [traffic\_policy\_id](#output\_traffic\_policy\_id) | ID of traffic policy |
| <a name="output_traffic_rule_id"></a> [traffic\_rule\_id](#output\_traffic\_rule\_id) | ID of traffic rule |
| <a name="output_traffic_rule_list_id"></a> [traffic\_rule\_list\_id](#output\_traffic\_rule\_list\_id) | ID of traffic rule list |
<!-- END_TF_DOCS -->