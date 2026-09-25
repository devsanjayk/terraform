locals {
  project = "terraformdemo"
  location  = "ci"

  common_tags = {
    environment = var.environment
    project     = local.project
  }

  # --- Fixed naming convention for this application (bank-app) ---
  # Same for every environment — only the module appends "-${var.environment}" internally

  vnet_name      = "bank-app"
  snet_app_name  = "bank-app_snet"
  snet_db_name   = "bank-db_snet"
  snet_mgmt_name = "bank-mgmt-snet"
  snet_pep_name  = "bank-pep-snet"



    # --- Address space / CIDR convention ---
  vnet_address_space    = ["10.10.0.0/16"]
  subnet_app_prefixes   = ["10.10.1.0/24"]
  subnet_db_prefixes    = ["10.10.2.0/24"]
  subnet_mgmt_prefixes  = ["10.10.3.0/24"]
  subnet_pep_prefixes   = ["10.10.4.0/24"]
}

locals {
  nsg_config = {
    app  = { subnet_key = "app",  subnet_name = local.snet_app_name }
    db   = { subnet_key = "db",   subnet_name = local.snet_db_name }
    mgmt = { subnet_key = "mgmt", subnet_name = local.snet_mgmt_name }
    pep  = { subnet_key = "pep",  subnet_name = local.snet_pep_name }
  }
}


module "resource_group" {
  source = "../../modules/resource-group"
  name = "${local.location}-customer-dashboard"
  location = var.location
  tags = var.tags
  environment = var.environment
}

module "networking" {
  source = "../../modules/networking"
  rg_name = module.resource_group.rg_name
  location = module.resource_group.rg_location
  environment = var.environment

  vnet_name      = local.vnet_name
  subnets = {
    app  = { name = local.snet_app_name,  address_prefixes = local.subnet_app_prefixes }
    db   = { name = local.snet_db_name,   address_prefixes = local.subnet_db_prefixes }
    mgmt = { name = local.snet_mgmt_name, address_prefixes = local.subnet_mgmt_prefixes }
    pep  = { name = local.snet_pep_name,  address_prefixes = local.subnet_pep_prefixes }
  }

}

module "nsg" {
  source = "../../modules/nsg"
  for_each = local.nsg_config

  rg_name = module.resource_group.rg_name
  location = module.resource_group.rg_location
  nsg_name = "ic-${each.value.subnet_name}-nsg-${var.environment}"
  subnet_id = module.networking.subnet_ids[each.value.subnet_key]
}