variable "resource_group_name" {

    description = "The name of the Resource Group where the VNet will be created."
    type        = string
  
}

variable "location" {
    description = "The Azure region to deploy the VNet in."
    type        = string
  
}
variable "key_vault_name" {
    description = "The name of the Key Vault to be created."
    type        = string
    default     = "myKeyVault"
  
}
variable "environment" {
    description = "The environment tag for the Key Vault."
    type        = string
    default     = "Development"
}

variable "service_principal_client_id" {
    description = "The client ID of the Service Principal to be stored in Key Vault."
    type        = string
}

variable "service_principal_secret_value" {
    description = "The value of the Service Principal secret to be stored in Key Vault."
    type        = string
}

variable "service_principal_object_id" {
    description = "The object ID of the Service Principal to grant access to Key Vault."
    type        = string
}

variable "tenant_id" {
    description = "The tenant ID for the Azure Active Directory."
    type        = string
}

variable "terraform_sp_object_id" {
    description = "The object ID of the Terraform Service Principal for Key Vault access."
    type        = string
}