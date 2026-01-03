# data "azuread_client_config" "current" simply fetches information about the identity Terraform is logged in with:

data "azuread_client_config" "current" {}
# tenant_id
# client_id  
# object_id

data "azurerm_client_config" "current" {}
# subscription_id
# tenant_id
# client_id
# object_id

# Create an Azure AD Application 
# Makes an App Registration named e.g. aks-service-principal.
# Adds the current caller as the owner (so we can manage it).
resource "azuread_application" "aks_app_registration" {
  display_name = var.service_principal_name
  owners       = [data.azuread_client_config.current.object_id]
}

# Create a Service Principal for the Azure AD Application
resource "azuread_service_principal" "aks_sp" {
  app_role_assignment_required = true
  client_id                    = azuread_application.aks_app_registration.client_id
  owners                       = [data.azuread_client_config.current.object_id]
}


resource "time_rotating" "rotate_timer" {
  rotation_days = 7
}

# Create a password (client secret) for the Service Principal
resource "azuread_service_principal_password" "sp_passw" {
  service_principal_id = azuread_service_principal.aks_sp.id
    rotate_when_changed = {
        rotation = time_rotating.rotate_timer.id
    }
}


# Because role assignment is a resource-level authorization, and only Azure Resource Manager owns and enforces resource permissions.

resource "random_uuid" "role_assign_id" {}

resource "azurerm_role_assignment" "sp_role_assignment" {
  name                 = random_uuid.role_assign_id.result
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.aks_sp.object_id
}
