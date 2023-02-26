
module naming {
  source  = "app.terraform.io/Farrellsoft/resource-naming/azure"
  version     = "1.0.1"
  //source      = "../azure-resource-naming"

  application         = var.application
  environment         = var.environment
  instance_number     = var.instance_number
}

data azurerm_client_config current {}

resource azurerm_storage_account sa {
  name                     = module.naming.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  account_kind             = var.account_kind
}

module containers {
  source = "./modules/blob-container"
  count  = length(var.containers)

  container_name        = var.containers[count.index].name
  storage_account_name  = azurerm_storage_account.sa.name
  role_assignments      = var.containers[count.index].role_assignments
}

resource azurerm_role_assignment this {
  count           = length(var.role_assignments)

  scope                = azurerm_storage_account.sa.id
  role_definition_name = var.role_assignments[count.index].role_definition_name
  principal_id         = var.role_assignments[count.index].object_id
}
