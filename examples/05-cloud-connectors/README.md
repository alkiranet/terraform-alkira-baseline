## Create Cloud Connectors
The following example configuration will connect:
- Two [alkira_connector_aws_vpc](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_aws_vpc) resources
- One [alkira_connector_azure_vnet](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_azure_vnet) resources
- One [alkira_connector_gcp_vpc](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_gcp_vpc) resources
- One [alkira_connector_oci_vcn](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_oci_vcn) resources

### Usage
To use this example, fill in the appropriate values in _variables.tf_ and provide those values _(including any secrets)_ by way of _terraform.tfvars_ or desired secrets management platform. Then run:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```