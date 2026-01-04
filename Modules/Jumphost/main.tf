resource "azurerm_network_interface" "jump_nic" {
  name                = "jump-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.jump_subnet_id[0]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "jump_host" {
  name                = "jump-host"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B2s"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.jump_nic.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("C:/Users/prasa/azurek8s.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    purpose = "aks-jump-host"
  }
}

resource "null_resource" "install_kubectl" {
  depends_on = [
    azurerm_linux_virtual_machine.jump_host
  ]

  connection {
    type        = "ssh"
    host        = azurerm_network_interface.jump_nic.private_ip_address
    user        = "azureuser"
    private_key = file("C:/Users/prasa/azurek8s")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y ca-certificates curl apt-transport-https",
      "curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -",
      "sudo apt-get update -y",
      "sudo apt-get install -y kubectl",
      "kubectl version --client"
    ]
  }
}
