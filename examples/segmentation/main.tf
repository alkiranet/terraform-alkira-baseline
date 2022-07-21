module "segmentation" {
  source = "alkiranet/baseline/alkira"

  # Path to .yml configuration files
  config_path = "./config/segmentation"

  # Provision billing tags, groups, and segments
  create_tags      = true
  create_groups    = true
  create_segments  = true

}