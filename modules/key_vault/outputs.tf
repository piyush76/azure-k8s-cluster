
output "key_vault_id" {
  value       = var.create_key_vault ? azurerm_key_vault.kv[0].id : null
  description = "The ID of the Key Vault"
}

output "key_vault_uri" {
  value       = var.create_key_vault ? azurerm_key_vault.kv[0].uri : null
  description = "The URI of the Key Vault"
}

output "key_vault_name" {
  value       = var.create_key_vault ? azurerm_key_vault.kv[0].name : null
  description = "The name of the Key Vault"
}
