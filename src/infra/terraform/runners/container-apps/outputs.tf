output "acrName" {
  value = module.acr.acrName
}

output "environmentName" {
  value = azurerm_container_app_environment.containerAppsEnvironment.name
  sensitive = true
}

output "resourceGroupName" {
  value = var.resourceGroupName
}
