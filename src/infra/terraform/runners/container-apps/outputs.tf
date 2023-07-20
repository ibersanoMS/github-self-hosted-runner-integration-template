output "acrName" {
  value = module.acr.acrName
}

output "environmentName" {
  value = azurerm_container_app_environment.containerAppsEnvironment.name
}

output "environmentId" {
  value = azurerm_container_app_environment.containerAppsEnvironment.id
  sensitive = true
}

output "resourceGroupName" {
  value = var.resourceGroupName
}
