
resource "azurerm_virtual_network" "AKS_VNet" {
  name                = "aks-network"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space_Vnet

  tags = {
    environment       = var.environment
  }
}

resource "azurerm_subnet" "AKS_Public_Subnet" {
  count                = length(var.Public_address_space)   
  name                 = "Vnet-Public-subnet-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.AKS_VNet.name
  address_prefixes     = [var.Public_address_space[count.index]]

}


resource "azurerm_subnet" "AKS_Private_Subnet" {
    count                = length(var.Private_address_space)   
    name                 = "Vnet-Private-subnet-${count.index + 1 + length(var.Public_address_space)}"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.AKS_VNet.name
    address_prefixes     = [var.Private_address_space[count.index]]

}

resource "azurerm_subnet_network_security_group_association" "assoc_public" {
  count                     = length(azurerm_subnet.AKS_Public_Subnet)

  subnet_id                 = azurerm_subnet.AKS_Public_Subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.Public_NSG.id
}

resource "azurerm_subnet_network_security_group_association" "assoc_private" {
  count                     = length(azurerm_subnet.AKS_Private_Subnet)

  subnet_id                 = azurerm_subnet.AKS_Private_Subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.Private_NSG.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_assoc" {
  count          = length(azurerm_subnet.AKS_Private_Subnet)
  subnet_id      = azurerm_subnet.AKS_Private_Subnet[count.index].id
  nat_gateway_id = azurerm_nat_gateway.Nat_Gateway.id
}
