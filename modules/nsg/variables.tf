

variable "rg_name" {
  type = string
  description = "Name of resource group"
}

variable "location" {
  type = string
  description = "Location of resource group"
}

variable "nsg_name" {
  type = string
  description = "Name of security group"
}

variable "subnet_id" {
  type = string
}

variable "security_rule" {
  type = list(object({
    name = string
    priority = number
    direction = string
    access = string
    protocol = string
    source_port_range = string
    destination_port_range = string
    source_address_prefix = string
    destination_address_prefix = string
  }))
  default = []
}