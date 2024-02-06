variable "connector_internet" {
  description = "Controls if internet connectors are created"
  type        = bool
  default     = false
}

variable "connector_internet_data" {
  type = list(object({

    # required
    cxp                                       = string
    name                                      = string
    segment                                   = string

    # optional
    billing_tags                              = optional(list(string), [])
    description                               = optional(string, "Created by Terraform")
    enabled                                   = optional(bool)
    group                                     = optional(string)
    public_ip_number                          = optional(number)
    traffic_distribution_algorithm            = optional(string)
    traffic_distribution_algorithm_attribute  = optional(string)

  }))
  default = []
}