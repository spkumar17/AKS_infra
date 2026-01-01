variable "resource_group_name" {

    description = "The name of the Resource Group where the VNet will be created."
    type        = string
  
}

variable "location" {
    description = "The Azure region to deploy the VNet in."
    type        = string
  
}

variable "address_space_Vnet" {
    description = "The address space that is used by the virtual network."
    type        = list(string)
    default     = ["10.0.0.0/16"]
  
}
variable "Public_address_space" {
    description = "The address space that is used by the virtual public subnets."
    type        = list(string)
    default     = ["10.0.1.0/24","10.0.2.0/24"]
}
variable "Private_address_space" {
    description = "The address space that is used by the virtual private subnets."
    type        = list(string)
    default     = ["10.0.3.0/24","10.0.4.0/24"]
}
variable "environment" {
    description = "The environment tag for the VNet."
    type        = string
    default     = "Development"
}

variable "nodeport_range" {
  type    = string
  default = "30000-32767"
}