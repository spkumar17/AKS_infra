variable "location" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "centralindia"
  
}

variable "name" {
    description = "The name of the Resource Group."
    type        = string
    default     = "Aks-resource-group"
}