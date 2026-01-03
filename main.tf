
module "ResourceGroup" {
  source   = "./Modules/ResourceGroup"
  location = "centralindia"
  name     = "Aks-resource-group"

}

module "VNet" {
  source                = "./Modules/VNet"
  resource_group_name   = module.ResourceGroup.resource_group_name
  location              = "centralindia"
  address_space_Vnet    = ["10.0.0.0/16"]
  Public_address_space  = ["10.0.1.0/24", "10.0.2.0/24"]
  Private_address_space = ["10.0.3.0/24", "10.0.4.0/24"]
  environment           = "Development"
  nodeport_range        = "30000-32767"

  depends_on = [module.ResourceGroup]

}

# module "Network_Watcher" {
#   source              = "./Modules/Network_watcher"
#   resource_group_name = module.ResourceGroup.resource_group_name
#   location            = "centralindia"
#   Public_nsg_id       = module.VNet.Public_nsg_id
#   Private_nsg_id      = module.VNet.Private_nsg_id
#   vnet_id             = module.VNet.vnet_id
#   storage_account_id  = module.storageaccount.storage_account_id
#   depends_on          = [module.storageaccount, module.VNet, module.ResourceGroup]
# }

module "storageaccount" {
  source               = "./Modules/Storageaccount"
  resource_group_name  = module.ResourceGroup.resource_group_name
  storage_account_name = "flownt006912"
  location             = "centralindia"
  depends_on           = [module.ResourceGroup]

}
module "Service_principle" {
  source               = "./Modules/Service_principle"
  role_definition_name = "Contributor"
  depends_on           = [module.ResourceGroup]

}

module "keyvault" {
  source                         = "./Modules/key_vault"
  resource_group_name            = module.ResourceGroup.resource_group_name
  location                       = "centralindia"
  service_principal_secret_value = module.Service_principle.service_principal_secret_value
  service_principal_object_id    = module.Service_principle.service_principal_object_id
  service_principal_client_id    = module.Service_principle.service_principal_client_id
  depends_on                     = [module.ResourceGroup, module.Service_principle]

}

module "AKS" {
  source                      = "./Modules/AKS"
  resource_group_name         = module.ResourceGroup.resource_group_name
  location                    = "centralindia"
  aks_cluster_name            = "aks-cluster"
  nodename                    = "agentpool"
  environment                 = "Development"
  vnet_subnet_id              = module.VNet.private_subnet_ids
  depends_on                  = [module.VNet, module.Service_principle, module.keyvault, module.ResourceGroup]
  
}