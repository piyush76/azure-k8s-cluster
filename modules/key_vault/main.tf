
resource "azurerm_key_vault" "kv" {
  count                       = var.create_key_vault ? 1 : 0
  name                        = "${var.cluster_name}-kv"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true
  sku_name                    = "standard"
  tags                        = var.tags
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "kv_role" {
  count                = var.create_key_vault && var.aks_identity_principal_id != null ? 1 : 0
  principal_id         = var.aks_identity_principal_id
  scope                = azurerm_key_vault.kv[0].id
  role_definition_name = "Key Vault Secrets User"
}
