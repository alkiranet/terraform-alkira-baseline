module "internet_connectors" {
  source  = "alkiranet/baseline/alkira"

  # Path to .yml configuration files
  config_file = "./connectors.yaml"

}