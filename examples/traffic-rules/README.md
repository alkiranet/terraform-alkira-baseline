## Traffic Rules
This example will build the constructs required for _traffic rules_ in Alkira.

- [Prefix Lists](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy_prefix_list) group prefixes that can then be used in _traffic rules_

- [Traffic Rules](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/policy_rule) are built using the standard stateless **5-tuple** specifications

### Routing to a service
For traffic to be routed to a specific service, like a _Firewall_ deployed from the _Marketplace_, set the **service_types** key in the _.yml_ configuration with the value of the service. Example values include **PAN** _Palo Alto_, **CHKPFW** _Check Point_, **FTNTFW** _Fortinet_, and **ZIA** _Zscaler_.

### Usage
```bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```