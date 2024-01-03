module "create_billing_tags" {
  source  = "alkiranet/baseline/alkira"

  # Path to .yml configuration files
  config_file = "./billing_tags.yaml"

}