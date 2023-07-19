resource "azurerm_container_registry" "runnerContainerRegistry" {
  name                     = "runnerContainerRegistry"
  resource_group_name      = var.resourceGroupName
  location                 = var.location
  sku                      = "Standard"
  admin_enabled            = false
}