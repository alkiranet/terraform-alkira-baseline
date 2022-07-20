# Create segments
resource "alkira_segment" "segment" {

  # Parse segments
  for_each = {
    for segment in local.segment_config.segments : segment.name => segment
    if var.create_segments == true
  }

  # Segment values
  name = each.value.name
  cidr = each.value.cidr
  asn  = try(each.value.asn, local.asn)

}

# Create connector groups
resource "alkira_group_connector" "group" {

  # Parse groups
  for_each = {
    for group in local.group_config.groups : group.name => group
    if var.create_groups == true && group.type == "connector"
  }

  # Group values
  name        = each.value.name
  description = try(each.value.description, local.description) 

}

# Create user groups
resource "alkira_group_user" "group" {

  # Parse groups
  for_each = {
    for group in local.group_config.groups : group.name => group
    if var.create_groups == true && group.type == "user"
  }

  # Group values
  name        = each.value.name
  description = try(each.value.description, local.description)

}

# Create billing tags
resource "alkira_billing_tag" "tag" {

  # Parse tags
  for_each = {
    for tag in local.tag_config.tags : tag.name => tag
    if var.create_tags == true
  }

  # Tag values
  name        = each.value.name
  description = try(each.value.description, local.description)

}

# Create prefix lists
resource "alkira_policy_prefix_list" "list" {

  # Parse prefixes
  for_each = {
    for list in local.list_config.lists : list.name => list
    if var.create_lists == true && list.type == "prefix"
  }

  # Prefix values
  name        = each.value.name
  description = try(each.value.description, local.description)
  prefixes    = each.value.prefixes

}