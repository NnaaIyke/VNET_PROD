# This is the provider for the Azure #

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.3.0"
    }
  }
}

#this subscription is for general prod
provider "azurerm" {
  features {}
  subscription_id = "6b6c23ac-12a7-4ddb-9a8e-043f53d430ff"
}

