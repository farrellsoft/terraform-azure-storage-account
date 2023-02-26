
// blob storage private endpoint
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

// file storage private endpoint
provider azurerm {
  alias         = "file-networking"
  subscription_id = can(var.private_connections.file.subnet_id) ? split("/", var.private_connections.file.subnet_id)[2] : data.azurerm_client_config.current.subscription_id
  features {}
}

module "file-private-endpoint" {
  source        = "../terraform-azure-private-endpoint"
  count         = can(var.private_connections.file.subnet_id) ? 1 : 0
  providers     = { azurerm = azurerm.file-networking }

  application         = var.application
  environment         = var.environment
  subnet_id           = var.private_connections.file.subnet_id
  resource_type       = "file"
  resource_group_name = var.private_connections.file.resource_group_name

  private_connections = {
    file = {
      resource_id         = azurerm_storage_account.sa.id
      subresource_names   = [
        "file"
      ]
      private_dns_zone_id = var.private_connections.file.private_dns_zone_id
    }
  }
}

// queue storage private endpoint
provider azurerm {
  alias         = "queue-networking"
  subscription_id = can(var.private_connections.queue.subnet_id) ? split("/", var.private_connections.queue.subnet_id)[2] : data.azurerm_client_config.current.subscription_id
  features {}
}

module "queue-private-endpoint" {
  source        = "../terraform-azure-private-endpoint"
  count         = can(var.private_connections.queue.subnet_id) ? 1 : 0
  providers     = { azurerm = azurerm.queue-networking }

  application         = var.application
  environment         = var.environment
  subnet_id           = var.private_connections.queue.subnet_id
  resource_type       = "queue"
  resource_group_name = var.private_connections.queue.resource_group_name

  private_connections = {
    queue = {
      resource_id         = azurerm_storage_account.sa.id
      subresource_names   = [
        "queue"
      ]
      private_dns_zone_id = var.private_connections.queue.private_dns_zone_id
    }
  }
}

// table storage private endpoint
provider azurerm {
  alias         = "table-networking"
  subscription_id = can(var.private_connections.table.subnet_id) ? split("/", var.private_connections.table.subnet_id)[2] : data.azurerm_client_config.current.subscription_id
  features {}
}

module "table-private-endpoint" {
  source        = "../terraform-azure-private-endpoint"
  count         = can(var.private_connections.table.subnet_id) ? 1 : 0
  providers     = { azurerm = azurerm.table-networking }

  application         = var.application
  environment         = var.environment
  subnet_id           = var.private_connections.table.subnet_id
  resource_type       = "table"
  resource_group_name = var.private_connections.table.resource_group_name

  private_connections = {
    table = {
      resource_id         = azurerm_storage_account.sa.id
      subresource_names   = [
        "table"
      ]
      private_dns_zone_id = var.private_connections.table.private_dns_zone_id
    }
  }
}