variable "cisco_sdwan" {
  description = "Controls if Cisco SDWAN connectors are created"
  type        = bool
  default     = false
}

variable "cisco_sdwan_data" {
  type = list(object({

    billing_tags   = optional(list(string), [])
    cxp            = string
    enabled        = optional(bool, true)
    group          = optional(string)
    name           = string
    size           = optional(string, "SMALL")
    type           = optional(string, "vedge")
    version        = string

    instance = optional(list(object({
      hostname         = string
      cloud_init_file  = string
      username         = optional(string, "netadmin")
      password         = optional(string, "netadmin")
    })))

    segment_mapping = optional(list(object({
      advertise_default_route   = optional(bool, false)
      advertise_on_prem_routes  = optional(bool, false)
      customer_asn              = string
      vrf_id                    = string
      segment                   = string
    })))

  }))
  default = []
}