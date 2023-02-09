
output storage_account {
  value = {
    id      = azurerm_storage_account.sa.id
    name    = azurerm_storage_account.sa.name
  }
}

output access_key {
  value     = azurerm_storage_account.sa.primary_access_key
  sensitive = true
}