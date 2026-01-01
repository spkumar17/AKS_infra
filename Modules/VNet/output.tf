
output "vnet_id" {
    value = azurerm_virtual_network.AKS_VNet.id
}


output "public_subnet_ids" {
    value = azurerm_subnet.AKS_Public_Subnet[*].id
  
}

output "private_subnet_ids" {
    value = azurerm_subnet.AKS_Private_Subnet[*].id
  
}

output "Public_nsg_id" {
    value = azurerm_network_security_group.Public_NSG.id
}

output "Private_nsg_id" {
    value = azurerm_network_security_group.Private_NSG.id
}