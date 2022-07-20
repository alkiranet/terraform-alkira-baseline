locals {

  # defaults
  asn         = "65514"
  description = "Created by Terraform"

  # segment configuration
  segment_file         = "./config/segments.yml"
  segment_file_content = fileexists(local.segment_file) ? file(local.segment_file) : file("${path.module}/templates/segments.yml")
  segment_config       = yamldecode(local.segment_file_content)

  # group configuration
  group_file         = "./config/groups.yml"
  group_file_content = fileexists(local.group_file) ? file(local.group_file) : file("${path.module}/templates/groups.yml")
  group_config       = yamldecode(local.group_file_content)

  # billing tag configuration
  tag_file         = "./config/tags.yml"
  tag_file_content = fileexists(local.tag_file) ? file(local.tag_file) : file("${path.module}/templates/tags.yml")
  tag_config       = yamldecode(local.tag_file_content)

  # list configuration
  list_file         = "./config/lists.yml"
  list_file_content = fileexists(local.list_file) ? file(local.list_file) : file("${path.module}/templates/lists.yml")
  list_config       = yamldecode(local.list_file_content)

}