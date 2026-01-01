variable "resource_group_name" {

    description = "The name of the Resource Group where the VNet will be created."
    type        = string
  
}

variable "location" {
    description = "The Azure region to deploy the VNet in."
    type        = string
  
}
variable "storage_account_name" {
    description = "The name of the Storage Account for Network Watcher flow logs."
    type        = string
    default     = "flownetworkwatcheracct_000912"
}
