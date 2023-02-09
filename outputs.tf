
output storage_account {
  value = {
    id      = azurerm_storage_account.storage_account.id
    name    = azurerm_storage_account.storage_account.name
  }
}

output access_key {
  value     = azurerm_storage_account.storage_account.primary_access_key
  sensitive = true
}