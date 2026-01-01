resource "azurerm_network_security_group" "Public_NSG" {
  name                = "public-security-group"
  location            = var.location
  resource_group_name = var.resource_group_name
  # Allow VNet internal traffic
  security_rule {
    name = "Allow-VNet-Inbound"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_address_prefix = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    source_port_range = "*"
    destination_port_range = "*"
  }

  # Allow LB health probes & load balancer traffic to NodePort range
  security_rule {
    name = "Allow-AzureLoadBalancer-NodePort"
    priority = 200
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_address_prefix = "AzureLoadBalancer"
    destination_address_prefix = "*"
    source_port_range = "*"
    destination_port_range = var.nodeport_range
  }

  # Allow HTTP/HTTPS to public subnets (only if you host web directly)
  security_rule {
    name = "Allow-HTTP"
    priority = 300
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    source_port_range = "*"
    destination_port_range = "80"
  }

  security_rule {
    name = "Allow-HTTPS"
    priority = 310
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    source_port_range = "*"
    destination_port_range = "443"
  }

  # SSH for public subnets
  security_rule {
    name = "Allow-SSH-From-Admin"
    priority = 400
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    source_port_range = "*"
    destination_port_range = "22"
  }

  # Outbound: allow ACR, Storage, KeyVault, Monitor via service tags
  security_rule {
    name = "Allow-Outbound-ACR"
    priority = 100
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "AzureContainerRegistry"
    source_port_range = "*"
    destination_port_range = "443"
  }

  security_rule {
    name = "Allow-Outbound-Storage"
    priority = 110
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "Storage"
    source_port_range = "*"
    destination_port_range = "443"
  }

  security_rule {
    name = "Allow-Outbound-Monitor"
    priority = 120
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "AzureMonitor"
    source_port_range = "*"
    destination_port_range = "443"
  }

  # DNS outbound if using custom DNS (leave broad if not sure)
  security_rule {
    name = "Allow-DNS-Outbound"
    priority = 200
    direction = "Outbound"
    access = "Allow"
    protocol = "Udp"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    source_port_range = "*"
    destination_port_range = "53"
  }
}


resource "azurerm_network_security_group" "Private_NSG" {
  name                = "private-security-group"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name = "Allow-VNet-Inbound"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_address_prefix = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    source_port_range = "*"
    destination_port_range = "*"
  }

  security_rule {
    name = "Allow-AzureLoadBalancer-NodePort"
    priority = 200
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_address_prefix = "AzureLoadBalancer"
    destination_address_prefix = "*"
    source_port_range = "*"
    destination_port_range = var.nodeport_range
  }
  

  # Outbound essential Azure services (ACR/Storage/KeyVault/Monitor)
  security_rule {
    name = "Allow-Outbound-ACR"
    priority = 100
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "AzureContainerRegistry"
    source_port_range = "*"
    destination_port_range = "443"
  }

  security_rule {
    name = "Allow-Outbound-Storage"
    priority = 110
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "Storage"
    source_port_range = "*"
    destination_port_range = "443"
  }

  security_rule {
    name = "Allow-Outbound-Monitor"
    priority = 120
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "AzureMonitor"
    source_port_range = "*"
    destination_port_range = "443"
  }

  security_rule {
    name = "Allow-DNS-Outbound"
    priority = 200
    direction = "Outbound"
    access = "Allow"
    protocol = "Udp"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    source_port_range = "*"
    destination_port_range = "53"
  }

  # optional deny inbound internet catch-all (unneeded because default exists, but explicit)
  security_rule {
    name = "Deny-Internet-Inbound"
    priority = 4096
    direction = "Inbound"
    access = "Deny"
    protocol = "*"
    source_address_prefix = "Internet"
    destination_address_prefix = "*"
    source_port_range = "*"
    destination_port_range = "*"
  }
}
