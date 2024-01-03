output "connector_internet_id" {
  value = try(module.internet_connectors.connector_internet_id, "")
}