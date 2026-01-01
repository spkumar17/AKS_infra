terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.50"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
provider "azuread" {
  tenant_id = var.tenant_id
}


terraform {
  backend "azurerm" {
    resource_group_name  = "terraformstatestoreblobgroup" # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "tfstatestore12"               # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                      # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "statename.tfstate"            # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}