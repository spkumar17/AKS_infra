variable "resource_group_name" {

    description = "The name of the Resource Group where the VNet will be created."
    type        = string
  
}

variable "location" {
    description = "The Azure region to deploy the VNet in."
    type        = string
  
}

variable "vnet_id" {
    description = "The ID of the Virtual Network to monitor."
    type        = string
  
}
 
variable "Public_nsg_id" {
    description = "The ID of the Network Security Group for public subnets."
    type        = string
  
}
variable "Private_nsg_id" {
    description = "The ID of the Network Security Group for private subnets."
    type        = string
  
}

variable "storage_account_id" {
    description = "The name of the Storage Account for Network Watcher flow logs."
    type        = string
    default     = "flownetworkwatcheracct"
}
