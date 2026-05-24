terraform {
  cloud {
    organization = "mrp-organization"
    workspaces {
      name = "mrpapi"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.73.0"
    }
  }
}

provider "azurerm" {
  features {}

}
