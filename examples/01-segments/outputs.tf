output "segment" {
  value = try(module.create_segments.segment_id, "")
}