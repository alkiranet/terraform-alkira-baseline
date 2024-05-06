variable "traffic_rule_list" {
  description = "Controls if rule lists are created"
  type        = bool
  default     = false
}

variable "traffic_rule_list_data" {
  type = list(object({
    name         = string
    description  = optional(string, "Created by Terraform")
    rules        = list(string)
  }))
  default = []
}

variable "traffic_rule" {
  description = "Controls if traffic rules are created"
  type        = bool
  default     = false
}

variable "traffic_rule_data" {
  type = list(object({
    name                      = string
    description               = optional(string, "Created by Terraform")
    rule_action               = optional(string, "ALLOW")
    dscp                      = optional(string, "any")
    protocol                  = optional(string, "tcp")
    src_ports                 = optional(list(string))
    dst_ports                 = optional(list(string))
    src_ip                    = optional(string)
    dst_ip                    = optional(string)
    src_prefix_list           = optional(string)
    dst_prefix_list           = optional(string)
    application               = optional(string)
    service_types             = optional(list(string))
  }))
  default = []
}

variable "traffic_policy" {
  description = "Controls if traffic policies are created"
  type        = bool
  default     = false
}

variable "traffic_policy_data" {
  type = list(object({
    name             = string
    description      = optional(string, "Created by Terraform")
    enabled          = optional(string, "true")
    rule_list        = string
    segment          = string
    from_connectors  = optional(list(string), [])
    to_connectors    = optional(list(string), [])
    from_groups      = optional(list(string), [])
    to_groups        = optional(list(string), [])
  }))
  default = []
}