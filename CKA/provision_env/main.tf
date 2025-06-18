terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.12"
    }
  }
}


provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}


resource "azurerm_resource_group" "rg" {
  location = var.rg_location
  name     = var.rg_name
}


module "vm_client" {
  source      = "./vm_client"
  rg_location = azurerm_resource_group.rg.location
  rg_name     = azurerm_resource_group.rg.name
  cp_vm_count = var.cp_vm_count
  wk_vm_count = var.wk_vm_count
}
