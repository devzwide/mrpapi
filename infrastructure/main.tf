resource "azurerm_resource_group" "rg-mrpapi-dev-southafricanorth" {
  name     = "rg-mrpapi-dev-southafricanorth"
  location = "South Africa North"

  tags = {
    environment = "dev"
    project     = "mrpapi"
  }
}

resource "azurerm_network_security_group" "nsg-mrpapi-dev-southafricanorth" {
  name                = "nsg-mrpapi-dev-southafricanorth"
  resource_group_name = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.name
  location            = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.location

  tags = {
    environment = "dev"
    project     = "mrpapi"
  }
}

resource "azurerm_virtual_network" "vnet-mrpapi-dev-southafricanorth" {
  name                = "vnet-mrpapi-dev-southafricanorth"
  resource_group_name = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.name
  location            = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.location
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "dev"
    project     = "mrpapi"
  }
}

resource "azurerm_subnet" "subnet-mrpapi-api-dev-southafricanorth" {
  name                 = "subnet-mrpapi-api-dev-southafricanorth"
  resource_group_name  = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.name
  virtual_network_name = azurerm_virtual_network.vnet-mrpapi-dev-southafricanorth.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet-mrpapi-db-dev-southafricanorth" {
  name                 = "subnet-mrpapi-db-dev-southafricanorth"
  resource_group_name  = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.name
  virtual_network_name = azurerm_virtual_network.vnet-mrpapi-dev-southafricanorth.name
  address_prefixes     = ["10.0.2.0/24"]
}