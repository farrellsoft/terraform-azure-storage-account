
resource azurerm_storage_account sa {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

module containers {
  source = "./modules/blob-container"
  count  = length(var.containers)

  container_name        = var.containers[count.index]
  storage_account_name  = var.storage_account_name

  depends_on = [
    sa
  ]
}