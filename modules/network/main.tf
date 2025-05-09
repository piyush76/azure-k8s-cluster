
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "${var.cluster_name}-vnet"
  address_space       = ["10.61.6.32/27"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.cluster_name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.61.6.32/28"]
}

resource "azurerm_subnet" "secondary_subnet" {
  name                 = "${var.cluster_name}-secondary-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.61.6.48/28"]
}
