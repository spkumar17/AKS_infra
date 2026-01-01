output "Vnetflow_log_id" {
    value = azurerm_network_watcher_flow_log.Vnet_flow_log.id
  
}

output "log_analytics_workspace_id" {
    value = azurerm_log_analytics_workspace.log_analytics.id
  
}

output "network_watcher_id" {
    value = azurerm_network_watcher.network_watcher.id
  
}
output "azurerm_network_watcher_name" {
    value = azurerm_network_watcher.network_watcher.name
}
