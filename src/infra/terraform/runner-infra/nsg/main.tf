resource "azurerm_network_security_group" "runnerNsg" {
  name = var.nsgName
  resource_group_name = var.resourceGroupName
  location = var.location
  tags = var.tags
}