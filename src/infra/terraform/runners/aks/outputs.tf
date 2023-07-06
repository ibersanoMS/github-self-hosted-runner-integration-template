output "clusterName" {
  value = azurerm_kubernetes_cluster.akscluster.name
}

output "resourceGroupName" {
    value = azurerm_kubernetes_cluster.akscluster.resource_group_name
}