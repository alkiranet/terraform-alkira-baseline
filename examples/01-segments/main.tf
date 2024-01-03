module "create_segments" {
  source  = "alkiranet/baseline/alkira"

  # Path to .yml configuration files
  config_file = "./segments.yaml"

}