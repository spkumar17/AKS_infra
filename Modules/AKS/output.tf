output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity
}
output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}


