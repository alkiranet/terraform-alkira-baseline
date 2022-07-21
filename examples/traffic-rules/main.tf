module "traffic_rules" {
  source = "alkiranet/baseline/alkira"

  # Path to .yml configuration files
  config_path = "./config/traffic-rules"

  # Provision prefix-lists and traffic rules
  create_lists      = true
  create_rules      = true

}