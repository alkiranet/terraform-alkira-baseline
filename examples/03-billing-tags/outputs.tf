output "billing_tag" {
  value = try(module.create_billing_tags.billing_tag_id, "")
}