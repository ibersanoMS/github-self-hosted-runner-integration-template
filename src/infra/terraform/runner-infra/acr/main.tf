resource "azurerm_container_registry" "runnerContainerRegistry" {
  name                     = "runnercontainerregistry"
  resource_group_name      = var.resourceGroupName
  location                 = var.location
  sku                      = "Standard"
  admin_enabled            = true
}
