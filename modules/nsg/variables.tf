

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