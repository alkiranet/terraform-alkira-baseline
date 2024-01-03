module "create_groups" {
  source  = "alkiranet/baseline/alkira"

  # Path to .yml configuration files
  config_file = "./groups.yaml"

}