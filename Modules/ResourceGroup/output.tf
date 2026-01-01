output "resource_group_name" {
  value = azurerm_resource_group.AksResourceGroup.name
}
output "resource_group_location" {
  value = azurerm_resource_group.AksResourceGroup.location
}