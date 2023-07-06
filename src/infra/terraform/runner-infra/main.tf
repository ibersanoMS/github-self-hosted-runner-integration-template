resource "azurerm_resource_group" "environmentRg" {
  name = var.resourceGroupName
  location = var.location
  tags = var.tags
}

module "vnet" {
    source = "./vnet"
    vnetName = var.vnetName
    resourceGroupName = azurerm_resource_group.environmentRg.name
    vnetAddressSpace = var.vnetAddressSpace
    subnetName = var.subnetName
    subnetAddressSpace = var.subnetAddressSpace
    location = var.location
    tags = var.tags
}

module "nsg" {
    source = "./nsg"
    resourceGroupName = azurerm_resource_group.environmentRg.name
    nsgName = var.nsgName
    location = var.location
    tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "associateNsgToRunnerSubnet" {
  subnet_id = module.vnet.subnetId
  network_security_group_id = module.nsg.nsgId
}