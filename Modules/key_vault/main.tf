data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "aks_key_vault" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.service_principal_object_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "example" {
  name         = var.service_principal_client_id
  value        = var.service_principal_secret_value
  key_vault_id = azurerm_key_vault.aks_key_vault.id
}

