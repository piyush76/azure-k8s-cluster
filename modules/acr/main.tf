
resource "azurerm_container_registry" "acr" {
  name                = replace("${var.cluster_name}acr", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.registries_sku
  admin_enabled       = false
  tags                = var.tags
}
