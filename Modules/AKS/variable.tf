variable "environment" {
    description = "The environment for the AKS cluster"
    type        = string
    default     = "Development"
  
}

variable "location" {
    description = "The location for the AKS cluster"
    type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
}
variable "aks_cluster_name" {
    description = "The name of the AKS cluster"
    type        = string
}

variable "nodename" {
    description = "The name of the AKS node pool"
    type        = string
}

variable "vnet_subnet_id" {
    description = "The ID of the subnet for the AKS cluster"
    type        = list(string)
}

variable "resource_group_id" {
    description = "The ID of the resource group"
    type        = string
}
