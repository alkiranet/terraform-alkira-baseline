variable "internet_application" {
  description = "Controls if Internet Applications are created"
  type        = bool
  default     = false
}

variable "internet_application_data" {
  type = list(object({

    # base vars
    billing_tag        = optional(string)
    connector_type     = string
    connector_name     = string
    fqdn_prefix        = string
    internet_protocol  = optional(string, "ipv4")
    name               = string
    segment            = string
    size               = optional(string, "SMALL")

    # target vars
    target  = optional(object({
      type          = string
      port_ranges   = optional(list(string), ["-1"])
      value         = string
    }))

  }))
  default = []
}