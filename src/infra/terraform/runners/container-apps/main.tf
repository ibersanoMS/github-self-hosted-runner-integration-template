module "acr" {
  source = "../../runner-infra/acr"
  resourceGroupName = var.resourceGroupName
  location = var.location
}

resource "azurerm_log_analytics_workspace" "containerAppsLaw" {
  name = var.logAnalyticsWorkspaceName
  location = var.location
  resource_group_name = var.resourceGroupName
  sku = "PerGB2018"
  retention_in_days = 30
}

resource "azurerm_container_app_environment" "containerAppsEnvironment" {
  name = var.containerAppsEnvironmentName
  location = var.location
  resource_group_name = var.resourceGroupName
  log_analytics_workspace_id = azurerm_log_analytics_workspace.containerAppsLaw.id
}