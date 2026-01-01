resource "azurerm_public_ip" "Nat_ip" {
  name                = "Nat_PIP"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "Nat_Gateway" {
  name                = "NatGateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "example" {
  nat_gateway_id       = azurerm_nat_gateway.Nat_Gateway.id
  public_ip_address_id = azurerm_public_ip.Nat_ip.id
}

