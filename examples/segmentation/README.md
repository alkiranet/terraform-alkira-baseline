## Segmentation
This example will provision the components required to enforce _segmentation_ in _Alkira_.

- [Segments](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/segment) _Segments_ are used for _macro-segmentation_.
- [Groups](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/group_connector) are used for _micro-segmentation_. Since Alkira has **connector** and **user** groups, add the **type** key to denote which group to create.
- [Billing Tags](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/billing_tag) can be created and applied to resources for _cost optimization_ purposes.

### Usage
```bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```