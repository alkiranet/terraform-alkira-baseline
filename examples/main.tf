module "baseline" {
  source = "alkiranet/baseline/alkira"

  # Provision billing tags, groups, and segments
  create_billing_tags    = true
  create_groups          = true
  create_segments        = true

}