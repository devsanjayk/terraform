
resource "azurerm_virtual_network" "vnet" {
    name = "ic-${var.vnet_name}-${var.environment}"
    resource_group_name = var.rg_name
    location = var.location

    address_space = [ "10.10.0.0/16" ]
}

# with for loop
resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name = "ic-${each.value.name}-${var.environment}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name
  address_prefixes = each.value.address_prefixes
}