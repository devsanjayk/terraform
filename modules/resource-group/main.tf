locals {
  project = "terraformdemo"

  common_tags = {
    environment = var.environment
    project = local.project
  }
}

resource "azurerm_resource_group" "main" {
  name = "${var.name}-${var.environment}-rg"
  location = var.location
  tags = var.tags
}