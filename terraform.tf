terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  cloud { 
    organization = "terraform-aa1"
    workspaces { 
      name = "aa-app-useast-dev" 
    } 
  } 
}