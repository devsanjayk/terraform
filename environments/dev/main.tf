

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

  security_rule = each.value.security_rule
}