
#This is the resource group that contains the Virtual Network in Prod 
data "azurerm_resource_group" "rgvnet" {
    name = "rg-connectivity01"
}

#This is the resource group that contains all Data Factory resources in Prod
#This particular one is to check the connectivity of ADF to On-prem SQL server through the PROD VNET.

data "azurerm_resource_group" "rgadf" {
    name = "Data-Factory-Signature"
}

data "azurerm_virtual_network" "vnet" {
  name                = "vnet-eus-generalnetwork001"
  resource_group_name = data.azurerm_resource_group.rgvnet.name
}

data "azurerm_data_factory" "this" {
  name                = "adf-emssins-dev"
  resource_group_name = data.azurerm_resource_group.rgadf.name
}

data "azurerm_private_link_service" "this" {
  name                = "adf-privatelinkservice-dev"
  resource_group_name = data.azurerm_resource_group.rgadf.name
}

#This resource block is for creating a VNET Manged private endpoint in ADF
resource "azurerm_data_factory_managed_private_endpoint" "this" {
  name               = "example"
  data_factory_id    = data.azurerm_data_factory.this.id
  target_resource_id = data.azurerm_private_link_service.this.id
  #fqdns              = "DC1-VP-SAPSTG.bbaaviation.net"
}

resource "azurerm_data_factory_integration_runtime_azure" "example" {
  name            = "adf-Integration-runtime"
  data_factory_id = data.azurerm_data_factory.this.id
  location        = data.azurerm_resource_group.rgadf.location
}