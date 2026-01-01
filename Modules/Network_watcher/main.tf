resource "azurerm_network_watcher" "network_watcher" {
  name                = "network_watcher"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "log-analytics-workspace"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
}

resource "azurerm_network_watcher_flow_log" "Vnet_flow_log" {
  name                    = "flow_log_vnet"
  network_watcher_name    = azurerm_network_watcher.network_watcher.name
  resource_group_name     = var.resource_group_name

  # IMPORTANT: must be the VNet (or subnet/NIC) ARM id
  target_resource_id      = var.vnet_id

  storage_account_id      = var.storage_account_id
  version                 = 2
  enabled                 = true

  retention_policy {
    enabled = true
    days    = 120
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.log_analytics.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.log_analytics.location
    workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
    interval_in_minutes   = 10
  }
}
