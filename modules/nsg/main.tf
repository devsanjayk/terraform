

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rg_name

  # dynamic "security_rule" {
  #   for_each = var.security_rule

  #   content {
  #     name = security_rule.value.name
  #     priority                    = security_rule.value.priority
  #     direction                   = security_rule.value.direction
  #     access                       = security_rule.value.access
  #     protocol                     = security_rule.value.protocol
  #     source_port_range            = security_rule.value.source_port_range
  #     destination_port_range       = security_rule.value.destination_port_range
  #     source_address_prefix        = security_rule.value.source_address_prefix
  #     destination_address_prefix   = security_rule.value.destination_address_prefix
  #   }
  # }
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_rule" "rule" {
  for_each = {for s in var.security_rule: s.name => s}

  access = each.value.access
  name = each.value.name
  protocol = each.value.protocol
  priority = each.value.priority
  direction = each.value.direction
  source_port_range = each.value.source_port_range
  destination_port_range       = each.value.destination_port_range
  source_address_prefix = each.value.source_address_prefix
  destination_address_prefix   = each.value.destination_address_prefix
  resource_group_name = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name

}