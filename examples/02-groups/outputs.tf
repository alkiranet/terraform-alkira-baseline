output "group" {
  value = try(module.create_groups.group_id, "")
}