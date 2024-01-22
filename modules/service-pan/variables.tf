variable "service_pan" {
  description = "Controls if Palo Alto Service is created"
  type        = bool
  default     = false
}

variable "pan_service_data" {
  type = list(object({

    billing_tags            = optional(list(string), [])
    bundle                  = optional(string, "VM_SERIES_BUNDLE_2")
    cxp                     = string
    instance                = optional(string, "instance-01")
    license_type            = optional(string, "PAY_AS_YOU_GO")
    management_segment      = string
    max_instance_count      = optional(string, "1")
    name                    = string
    registration_pin_expiry = string
    registration_pin_id     = string
    registration_pin_value  = string
    segments                = list(string)
    
    segment_options  = optional(list(object({
      groups     = list(string)
      segment    = string
      zone_name  = string
    })))

    size             = optional(string, "SMALL")
    type             = optional(string, "VM-300")
    username         = optional(string, "admin")
    password         = optional(string, "NetAdmin2024")
    version          = string
  }))
  default = []
}