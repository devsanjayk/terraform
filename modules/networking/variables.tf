variable "environment" {
  type = string
  description = "Environment"
}
variable "rg_name" {
  type = string
  description = "Name of resource group"
}

variable "location" {
  type = string
  description = "Location of resource group"
}

variable "vnet_name" {
  type = string
  description = "Virtual network name"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.10.0.0/16"]
}

# for loop subnet
variable "subnets" {
  type = map(object({
    name = string
    address_prefixes = list(string)
  }))
  description = "map of subnet need to create"
}