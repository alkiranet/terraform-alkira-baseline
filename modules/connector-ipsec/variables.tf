variable "connector_ipsec" {
  description = "Controls if IPSec connectors are created"
  type        = bool
  default     = false
}

variable "connector_ipsec_data" {
  type = list(object({

    # base vars
    cxp         = string
    customer_gateway_asn = string
    enabled     = optional(string, true)
    group       = optional(string)
    name        = string
    segment     = string
    size        = optional(string, "SMALL")

    # endpoint vars
    endpoints  = optional(list(object({
      billing_tags              = optional(list(string), [])
      customer_gateway_ip       = string
      enable_tunnel_redundancy  = optional(string, true)
      name                      = string
      preshared_keys            = optional(list(string), [])
    })))

    # routing option vars
    routing_options  = optional(object({
      availability          = optional(string, "IPSEC_INTERFACE_PING")
      bgp_auth_key          = optional(string)
      customer_gateway_asn  = string
      type                  = optional(string, "DYNAMIC")
    }))

    # segment option vars
    segment_options  = optional(object({
      advertise_default_route   = optional(string, false)
      advertise_on_prem_routes  = optional(string, false)
    }))

  }))
  default = []
}