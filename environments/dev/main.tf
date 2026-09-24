locals {
  project = "terraformdemo"
  location = "ci"

  common_tags = {
    environment = var.environment
    project = local.project
  }
}

module "resource_group" {
  source = "../../modules/resource-group"
  name = "${local.location}-customer-dashboard"
  location = var.location
  tags = var.tags
  environment = var.environment
}