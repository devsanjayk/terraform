variable "environment" {
  type = string
  description = "Environment"
}

variable "location" {
  type = string
  description = "Azure location"
  default = "Central India"
}

variable "subscription_id" {
  type = string
  description = "Azure subscription id"
}

variable "tags" {
  type = map(string)
  description = "Common tags"
  default = {
  }
}