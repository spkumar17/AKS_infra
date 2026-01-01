
resource "azurerm_resource_group" "AksResourceGroup" {
  name     = var.name
  location = var.location
}