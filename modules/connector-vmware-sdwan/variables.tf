variable "vmware_sdwan" {
  description = "Controls if VMware SDWAN connectors are created"
  type        = bool
  default     = false
}

variable "vmware_sdwan_data" {
  type = list(object({

    billing_tags       = optional(list(string), [])
    cxp                = string
    enabled            = optional(bool, true)
    group              = optional(string)
    name               = string
    orchestrator_host  = string
    size               = optional(string, "SMALL")
    version            = string

    instance = optional(list(object({
      activation_code  = string
      hostname         = string
    })))

    segment_mapping = optional(list(object({
      advertise_default_route    = optional(bool, false)
      advertise_on_prem_routes   = optional(bool, false)
      customer_asn               = optional(string)
      segment                    = string
      vmware_sdwan_segment_name  = string
    })))

  }))
  default = []
}