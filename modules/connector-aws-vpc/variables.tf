variable "aws_vpc" {
  description = "Controls if AWS VPC connectors are created"
  type        = bool
  default     = false
}

variable "aws_vpc_data" {
  type = list(object({
    aws_account_id     = string
    billing_tag        = optional(string)
    credential         = string
    cxp                = string
    enabled            = optional(string, true)
    group              = optional(string)
    name               = string
    network_cidr       = string
    network_id         = string
    region             = string
    route_table_id     = string
    segment            = string
    size               = optional(string, "SMALL")
  }))
    default = []
}