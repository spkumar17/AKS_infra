variable "location" {}
variable "resource_group_name" {}
variable "jump_subnet_id" {
    description = "The ID of the subnet for the Jump Host"
    type        = list(string)
}

variable "vnet_name" {
  
}

variable "address_prefixes" {
    description = "The address prefixes for the bastion subnet"
    type        = list(string)
  
}

variable "aks_id" {}
