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

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "dev"
    project     = "mrpapi"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet-mrpapi-api-dev-southafricanorth-nsg-association" {
  subnet_id                 = azurerm_subnet.subnet-mrpapi-api-dev-southafricanorth.id
  network_security_group_id = azurerm_network_security_group.nsg-mrpapi-dev-southafricanorth.id
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

resource "azurerm_container_registry" "acr-mrpapi-dev-southafricanorth" {
  name                = "acrmrpapidevsanorth"
  resource_group_name = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.name
  location            = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.location
  sku                 = "Basic"
  admin_enabled       = false

  tags = {
    environment = "dev"
    project     = "mrpapi"
  }
}

resource "azurerm_log_analytics_workspace" "loganalytics-mrpapi-dev-southafricanorth" {
  name                = "loganalytics-mrpapi-dev-southafricanorth"
  resource_group_name = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.name
  location            = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.location
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    environment = "dev"
    project     = "mrpapi"
  }
}

resource "azurerm_kubernetes_cluster" "aks-mrpapi-dev-southafricanorth" {
  name                = "aks-mrpapi-dev-southafricanorth"
  resource_group_name = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.name
  location            = azurerm_resource_group.rg-mrpapi-dev-southafricanorth.location
  dns_prefix          = "aks-mrpapi-dev-southafricanorth"
  node_resource_group = "rg-aks-nodes-mrpapi-dev-sanorth"

  default_node_pool {
    name           = "default"
    node_count     = 2
    vm_size        = "Standard_B2s"
    vnet_subnet_id = azurerm_subnet.subnet-mrpapi-api-dev-southafricanorth.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    environment = "dev"
    project     = "mrpapi"
  }
}

resource "azurerm_role_assignment" "aks-mrpapi-dev-southafricanorth-acr-pull" {
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr-mrpapi-dev-southafricanorth.id
  principal_id                     = azurerm_kubernetes_cluster.aks-mrpapi-dev-southafricanorth.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}