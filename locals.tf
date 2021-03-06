locals {

  # defaults
  asn         = "65514"
  description = "Created by Terraform"

  # group configuration
  group_file         = "${var.config_path}/groups.yml"
  group_file_content = fileexists(local.group_file) ? file(local.group_file) : file("${path.module}/templates/groups.yml")
  group_config       = yamldecode(local.group_file_content)

  # list configuration
  list_file         = "${var.config_path}/lists.yml"
  list_file_content = fileexists(local.list_file) ? file(local.list_file) : file("${path.module}/templates/lists.yml")
  list_config       = yamldecode(local.list_file_content)

  # segment configuration
  segment_file         = "${var.config_path}/segments.yml"
  segment_file_content = fileexists(local.segment_file) ? file(local.segment_file) : file("${path.module}/templates/segments.yml")
  segment_config       = yamldecode(local.segment_file_content)

  # tag configuration
  tag_file         = "${var.config_path}/tags.yml"
  tag_file_content = fileexists(local.tag_file) ? file(local.tag_file) : file("${path.module}/templates/tags.yml")
  tag_config       = yamldecode(local.tag_file_content)

  # rule configuration
  rule_file         = "${var.config_path}/rules.yml"
  rule_file_content = fileexists(local.rule_file) ? file(local.rule_file) : file("${path.module}/templates/rules.yml")
  rule_config       = yamldecode(local.rule_file_content)

}