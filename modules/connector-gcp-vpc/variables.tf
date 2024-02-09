variable "gcp_vpc" {
  description = "Controls if GCP VPC connectors are created"
  type        = bool
  default     = false
}


variable "gcp_vpc_data" {
  type = list(object({
    billing_tag      = optional(string)
    credential       = string
    cxp              = string
    group            = optional(string)
    name             = string
    region           = optional(string)
    segment          = string
    size             = optional(string, "SMALL")
    vpc_name         = string
  }))
    default = []
}