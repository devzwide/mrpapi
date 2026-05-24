resource "azurerm_resource_group" "rg-mrpapi-dev-southafricanorth" {
  name     = "rg-mrpapi-dev-southafricanorth"
  location = "South Africa North"

  tags = {
    environment = "dev"
    project     = "mrpapi"
  }
}