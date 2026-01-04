data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "aks_key_vault" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7
  }

resource "azurerm_key_vault_access_policy" "terraform_sp" {
  key_vault_id = azurerm_key_vault.aks_key_vault.id
  tenant_id    = var.tenant_id
  object_id    = var.terraform_sp_object_id

  secret_permissions = [
    "Get",
    "Set",
    "List",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge"
  ]
}


resource "azurerm_key_vault_secret" "service_principal_secret" {
  name         = var.service_principal_client_id
  value        = var.service_principal_secret_value
  key_vault_id = azurerm_key_vault.aks_key_vault.id
  depends_on = [ azurerm_key_vault.aks_key_vault,azurerm_key_vault_access_policy.terraform_sp ]
  
}

