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
    protocol                  = optional(string, "any")
    src_ports                 = optional(list(string), ["any"])
    dst_ports                 = optional(list(string), ["any"])
    src_prefix_list           = string
    dst_prefix_list           = string
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
    name         = string
    description  = optional(string, "Created by Terraform")
    enabled      = optional(string, "true")
    rule_list    = string
    segment      = string
    from_groups  = list(string)
    to_groups    = list(string)
  }))
  default = []
}