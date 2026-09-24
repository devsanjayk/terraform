variable "environment" {
  type = string
  description = "Environment"
}

variable "location" {
  type = string
  description = "Azure location"
  default = "Central India"
}

variable "tags" {
  type = map(string)
  description = "Common tags"
  default = {
  }
}

variable "name" {
  type = string
  description = "Resource name"
}