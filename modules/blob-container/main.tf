
resource azurerm_storage_container this {
  name                  = var.container_name
  storage_account_name  = var.storage_account_name
}

resource azurerm_role_assignment this {
  count         = length(var.role_assignments)

  scope                = azurerm_storage_container.this.resource_manager_id
  role_definition_name = var.role_assignments[count.index].role_definition_name
  principal_id         = var.role_assignments[count.index].object_id
}