
# Output for the Tenant ID
output "service_principal_tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}
output "aks_app_registration_object_id" {
    value = azuread_application.aks_app_registration.object_id
}

# Outputs for the Service Principal

output "service_principal_display_name" {
  value = azuread_service_principal.aks_sp.display_name
}

output "service_principal_client_id" {  # this is same as application id in app registrations
  description = "The client id of the Service Principal"
  value       = azuread_service_principal.aks_sp.client_id
}

output "service_principal_object_id" {
  value = azuread_service_principal.aks_sp.object_id
}


# Outputs for the Service Principal Secrets
output "service_principal_secret_id" {
    description = "The id of the Service Principal secret"
    value       = azuread_service_principal_password.sp_passw.id 
    sensitive = true

  }

output "service_principal_secret_value" {
    description = "The client secret of the Service Principal"
    value       = azuread_service_principal_password.sp_passw.value
    sensitive = true

}  