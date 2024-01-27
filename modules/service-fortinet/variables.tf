variable "service_fortinet" {
  description = "Controls if Fortinet Service is created"
  type        = bool
  default     = false
}

variable "fortinet_service_data" {
  type = list(object({

    billing_tags            = optional(list(string), [])
    cxp                     = string
    license_type            = optional(string, "PAY_AS_YOU_GO")
    management_segment      = string
    max_instance_count      = optional(string, "1")
    min_instance_count      = optional(string, "1")
    name                    = string
    segments                = list(string)

    instances  = optional(list(object({
      name                   = string
      license_key_file_path  = string
    })))
    
    segment_options  = optional(list(object({
      groups     = list(string)
      segment    = string
      zone_name  = string
    })))

    size             = optional(string, "SMALL")
    tunnel_protocol  = optional(string, "IPSEC")
    username         = optional(string, "admin")
    password         = optional(string, "NetAdmin2024")
    version          = string
  }))
  default = []
}