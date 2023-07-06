# Creates cluster with default linux node pool
resource "azurerm_kubernetes_cluster" "akscluster" {
  name                      = var.clusterName
  location                  = var.location
  resource_group_name       = var.resourceGroupName
  kubernetes_version        = "1.25.5"
  dns_prefix                = var.clusterName
  identity {
    type = "SystemAssigned"
  }
  default_node_pool {
    name                         = "defaultpool"
    vm_size                      = "Standard_DS2_v2"
    os_disk_size_gb              = 30
    os_disk_type                 = "Ephemeral"
    type                         = "VirtualMachineScaleSets"
    enable_auto_scaling          = true
    min_count                    = 3
    max_count                    = 4
    vnet_subnet_id               = var.vnetSubnetId
    only_critical_addons_enabled = true
    zones                        = ["1", "2", "3"]
    upgrade_settings {
      max_surge = "33%"
    }
  }

  network_profile {
    network_plugin    = "kubenet"
  }
}


resource "azurerm_kubernetes_cluster_node_pool" "linux_user_pool" {
  name                  = "usernodepool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.akscluster.id
  vm_size               = "Standard_DS2_v2"
  os_disk_size_gb       = 30
  os_disk_type          = "Ephemeral"
  enable_auto_scaling   = true
  min_count             = 1
  max_count             = 3
  os_type               = "Linux"
  vnet_subnet_id        = var.vnetSubnetId
  zones                 = ["1", "2", "3"]
}

# Outputs
output "aks_id" {
  value = azurerm_kubernetes_cluster.akscluster.id
}

output "node_pool_rg" {
  value = azurerm_kubernetes_cluster.akscluster.node_resource_group
}