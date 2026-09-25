moved {
  from = module.networking.azurerm_subnet.subnet_app
  to   = module.networking.azurerm_subnet.subnet["app"]
}

moved {
  from = module.networking.azurerm_subnet.subnet_db
  to   = module.networking.azurerm_subnet.subnet["db"]
}

moved {
  from = module.networking.azurerm_subnet.subnet_mgmt
  to   = module.networking.azurerm_subnet.subnet["mgmt"]
}

moved {
  from = module.networking.azurerm_subnet.subnet_pep
  to   = module.networking.azurerm_subnet.subnet["pep"]
}

moved {
  from = module.nsg_app.azurerm_network_security_group.nsg
  to   = module.nsg["app"].azurerm_network_security_group.nsg
}

moved {
  from = module.nsg_db.azurerm_network_security_group.nsg
  to   = module.nsg["db"].azurerm_network_security_group.nsg
}

moved {
  from = module.nsg_mgmt.azurerm_network_security_group.nsg
  to   = module.nsg["mgmt"].azurerm_network_security_group.nsg
}

moved {
  from = module.nsg_pep.azurerm_network_security_group.nsg
  to   = module.nsg["pep"].azurerm_network_security_group.nsg
}