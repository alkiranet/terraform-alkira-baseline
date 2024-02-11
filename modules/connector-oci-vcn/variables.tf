variable "oci_vcn" {
  description = "Controls if OCI Connectors are created"
  type        = bool
  default     = false
}

variable "oci_vcn_data" {
  type = list(object({
    billing_tag        = optional(string)
    compartment_id     = optional(string)
    region             = string
    credential         = string
    cxp                = string
    group              = optional(string)
    name               = string
    network_cidr       = optional(string)
    network_id         = optional(string)
    segment            = string
    size               = optional(string, "SMALL")
  }))
    default = []
}