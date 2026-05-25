resource "azurerm_resource_group" "rg-mrpapi-dev-southafricanorth" {
  name     = "rg-mrpapi-dev-southafricanorth"
  location = "South Africa North"

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