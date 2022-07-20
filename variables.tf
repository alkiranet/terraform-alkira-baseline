variable "config_path" {
  description = "Path to .yml files"
  type        = string
  default     = "./config/"
}

variable "create_segments" {
  description = "Controls if segments are created"
  type        = bool
  default     = false
}

variable "create_groups" {
  description = "Controls if groups are created"
  type        = bool
  default     = false
}

variable "create_tags" {
  description = "Controls if billing tags are created"
  type        = bool
  default     = false
}

variable "create_lists" {
  description = "Controls if lists are created"
  type        = bool
  default     = false
}