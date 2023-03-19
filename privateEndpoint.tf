
// blob storage private endpoint
#provider azurerm {
#  alias         = "blob-networking"
#  subscription_id = can(var.private_endpoints.blob.subnet_id) ? split("/", var.private_endpoints.blob.subnet_id)[2] : data.azurerm_client_config.current.subscription_id
#  features {}
#}
#
module "blob-private-endpoint" {
  source        = "../terraform-azure-private-endpoint"
  count         = length(var.private_endpoints.blobs)
  #providers     = { azurerm = azurerm.blob-networking }

  application         = var.application
  environment         = var.environment
  subnet_id           = var.private_endpoints.blobs[count.index].subnet_id
  resource_type       = "blob"
  resource_group_name = var.private_endpoints.blobs[count.index].resource_group_name

  private_connections = {
    blob = {
      resource_id         = azapi_resource.this.id
      purpose             = var.private_endpoints.blobs[count.index].purpose
      subresource_names   = [
        "blob"
      ]
      private_dns_zone_id = var.private_endpoints.blobs[count.index].private_dns_zone_id
    }
  }
}
#
#// file storage private endpoint
#provider azurerm {
#  alias         = "file-networking"
#  subscription_id = can(var.private_endpoints.file.subnet_id) ? split("/", var.private_endpoints.file.subnet_id)[2] : data.azurerm_client_config.current.subscription_id
#  features {}
#}
#
module "file-private-endpoint" {
  source        = "../terraform-azure-private-endpoint"
  count         = length(var.private_endpoints.files)
#  providers     = { azurerm = azurerm.file-networking }

  application         = var.application
  environment         = var.environment
  subnet_id           = var.private_endpoints.files[count.index].subnet_id
  resource_type       = "file"
  resource_group_name = var.private_endpoints.files[count.index].resource_group_name

  private_connections = {
    file = {
      resource_id         = azapi_resource.this.id
      purpose             = var.private_endpoints.files[count.index].purpose
      subresource_names   = [
        "file"
      ]
      private_dns_zone_id = var.private_endpoints.files[count.index].private_dns_zone_id
    }
  }
}
#
#// queue storage private endpoint
#provider azurerm {
#  alias         = "queue-networking"
#  subscription_id = can(var.private_endpoints.queue.subnet_id) ? split("/", var.private_endpoints.queue.subnet_id)[2] : data.azurerm_client_config.current.subscription_id
#  features {}
#}
#
module "queue-private-endpoint" {
  source        = "../terraform-azure-private-endpoint"
  count         = length(var.private_endpoints.queues)
#  providers     = { azurerm = azurerm.queue-networking }

  application         = var.application
  environment         = var.environment
  subnet_id           = var.private_endpoints.queues[count.index].subnet_id
  resource_type       = "queue"
  resource_group_name = var.private_endpoints.queues[count.index].resource_group_name

  private_connections = {
    queue = {
      resource_id         = azapi_resource.this.id
      purpose            = var.private_endpoints.queues[count.index].purpose
      subresource_names   = [
        "queue"
      ]
      private_dns_zone_id = var.private_endpoints.queues[count.index].private_dns_zone_id
    }
  }
}
#
#// table storage private endpoint
#provider azurerm {
#  alias         = "table-networking"
#  subscription_id = can(var.private_endpoints.table.subnet_id) ? split("/", var.private_endpoints.table.subnet_id)[2] : data.azurerm_client_config.current.subscription_id
#  features {}
#}
#
module "table-private-endpoint" {
  source        = "../terraform-azure-private-endpoint"
  count         = length(var.private_endpoints.tables)
#  providers     = { azurerm = azurerm.table-networking }

  application         = var.application
  environment         = var.environment
  subnet_id           = var.private_endpoints.tables[count.index].subnet_id
  resource_type       = "table"
  resource_group_name = var.private_endpoints.tables[count.index].resource_group_name

  private_connections = {
    table = {
      resource_id         = azapi_resource.this.id
      purpose             = var.private_endpoints.tables[count.index].purpose
      subresource_names   = [
        "table"
      ]
      private_dns_zone_id = var.private_endpoints.tables[count.index].private_dns_zone_id
    }
  }
}