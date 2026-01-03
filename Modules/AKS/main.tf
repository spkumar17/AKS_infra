resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix_private_cluster = "aksdns_private"
  

  private_cluster_enabled = true
  private_dns_zone_id      = "System"
  default_node_pool {
    name       = var.nodename
    auto_scaling_enabled = true
    min_count           = 1
    max_count           = 3
    vm_size    = "Standard_DS2_v2"
    type       = "System"
    os_disk_size_gb = 30
    vnet_subnet_id    = var.vnet_subnet_id[0]
  }
  network_profile {
    network_plugin = "azure"
  }

  identity {
    type = "SystemAssigned"
  }

   tags = {
    Environment = var.environment
      }

}

resource "azurerm_kubernetes_cluster_node_pool" "user_np" {
  name                  = "usernp"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id

  vm_size    = "Standard_DS3_v2"
  auto_scaling_enabled  = true
  min_count           = 1
  max_count           = 3
  mode       = "User"
  vnet_subnet_id    = var.vnet_subnet_id[1]
  os_disk_size_gb = 50

  node_labels = {
    workload = "app"
  }
  

  node_taints = [
    "workload=app:NoSchedule"
  ]

  tags = {
    Environment = var.environment
      }
}

# Assigning AcrPull role to the AKS kubelet identity
# The scope must point to the resource group where the ACR is located

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.resource_group_id
}

# For managed disk access, the scope must point to the resource group where disks are created
resource "azurerm_role_assignment" "aks_disk_access" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "Contributor"
  scope                = var.resource_group_id
}
