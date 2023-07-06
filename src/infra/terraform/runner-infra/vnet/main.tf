resource azurerm_virtual_network "vnet" {
  name                = var.vnetName
  address_space       = ["${var.vnetAddressSpace}"]
  location            = var.location
  resource_group_name = var.resourceGroupName
  tags                = var.tags
}

resource "azurerm_subnet" "runnerSnet" {
  name = var.subnetName
  resource_group_name = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["${var.subnetAddressSpace}"]
}