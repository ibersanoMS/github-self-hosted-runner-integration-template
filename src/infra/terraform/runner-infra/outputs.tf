output "runnerSubnetId" {
  value = module.vnet.subnetId
}

output "vnetId" {
  value = module.vnet.vnetId
}

output "resourceGroupName" {
  value = azurerm_resource_group.environmentRg.name
}