variable "billing_tag" {
  description = "Controls if billing tags are created"
  type        = bool
  default     = false
}

variable "billing_tag_data" {
  type = list(object({
    name        = string
    description = optional(string, "Created by Terraform")
  }))
  default = []
}

variable "group" {
  description = "Controls if groups are created"
  type        = bool
  default     = false
}

variable "group_data" {
  type = list(object({
    name        = string
    description = optional(string, "Created by Terraform")
    type        = optional(string, "connector")
  }))
  default = []
}

variable "global_cidr_list" {
  description = "Controls if global cidr lists are created"
  type        = bool
  default     = false
}

variable "global_cidr_list_data" {
  type = list(object({
    name        = string
    cxp         = string
    description = optional(string, "Created by Terraform")
    values      = list(string)
  }))
  default = []
}

variable "prefix_list" {
  description = "Controls if prefix lists are created"
  type        = bool
  default     = false
}

variable "prefix_list_data" {
  type = list(object({
    name        = string
    description = optional(string, "Created by Terraform")
    values      = list(string)
  }))
  default = []
}

variable "segment" {
  description = "Controls if segments are created"
  type        = bool
  default     = false
}

variable "segment_data" {
  type = list(object({

    # required
    cidrs  = list(string)
    name   = string

    # optional
    asn                              = optional(string)
    description                      = optional(string, "Created by Terraform")
    enable_ipv6_to_ipv4_translation  = optional(bool)
    enterprise_dns_server_ip         = optional(string)
    reserve_public_ips               = optional(bool)
    src_ipv4_pool_end_ip             = optional(string)
    src_ipv4_pool_start_ip           = optional(string)

  }))
  default = []
}