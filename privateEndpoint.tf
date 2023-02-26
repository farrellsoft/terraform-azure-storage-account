
provider azurerm {
  alias         = "blob-networking"
  subscription_id = can(var.private_connections.blob.subnet_id) ? split("/", var.private_connections.blob.subnet_id)[2] : data.azurerm_client_config.current.subscription_id
  features {}
}

module "blob-private-endpoint" {
  source        = "../terraform-azure-private-endpoint"
  count         = can(var.private_connections.blob.subnet_id) ? 1 : 0
  providers     = { azurerm = azurerm.blob-networking }

  application         = var.application
  environment         = var.environment
  subnet_id           = var.private_connections.blob.subnet_id
  resource_type       = "blob"
  resource_group_name = var.private_connections.blob.resource_group_name

  private_connections = {
    blob = {
      resource_id         = azurerm_storage_account.sa.id
      subresource_names   = [
        "blob"
      ]
      private_dns_zone_id = var.private_connections.blob.private_dns_zone_id
    }
  }
}