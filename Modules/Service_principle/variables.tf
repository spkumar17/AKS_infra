variable "service_principal_name" {
    description = "The name of the Service Principal."
    type        = string
    default     = "aks-service-principal"
  
}

variable "role_definition_name" {
    description = "The role to assign to the Service Principal."
    type        = string
    default     = "Contributor"
  
}
