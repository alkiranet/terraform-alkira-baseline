variable "azure_vnet" {
  description = "Controls if Azure VNet connectors are created"
  type        = bool
  default     = false
}

variable "azure_vnet_data" {
  type = list(object({
    credential       = string
    cxp              = string
    group            = optional(string)
    name             = string
    network_cidr     = string
    network_id       = string
    resource_group   = string
    segment          = string
    size             = optional(string, "SMALL")
  }))
    default = []
}