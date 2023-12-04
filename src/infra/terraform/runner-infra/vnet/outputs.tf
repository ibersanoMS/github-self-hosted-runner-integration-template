output "subnetId" {
  value = azurerm_subnet.runnerSnet.id
}

output "vnetId" {
  value = azurerm_virtual_network.vnet.id
}