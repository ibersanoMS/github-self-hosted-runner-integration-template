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

resource "azurerm_user_assigned_identity" "containerAppsJobIdentity" {
  name = "containerAppsJobIdentity"
  location = var.location
  resource_group_name = var.resourceGroupName
}

resource "azurerm_role_assignment" "acrPullRoleAssignment" {
  scope = module.acr.acrId
  role_definition_name = "AcrPull"
  principal_id = azurerm_user_assigned_identity.containerAppsJobIdentity.principal_id
}

resource "azurerm_container_app_environment" "containerAppsEnvironment" {
  name = var.containerAppsEnvironmentName
  location = var.location
  resource_group_name = var.resourceGroupName
  log_analytics_workspace_id = azurerm_log_analytics_workspace.containerAppsLaw.id
}