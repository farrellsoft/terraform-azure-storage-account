
terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

module naming {
  source      = "app.terraform.io/Farrellsoft/resource-naming/azure"
  version     = "1.0.1"
  //source      = "../azure-resource-naming"

  application         = var.application
  environment         = var.environment
  instance_number     = var.instance_number
}


data azurerm_client_config current {}
locals {
  resource_group_id       = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"
}

resource azapi_resource this {
  type                  = "Microsoft.Storage/storageAccounts@2022-09-01"
  name                  = module.naming.storage_account_name
  parent_id             = local.resource_group_id
  location              = var.location

  body          = jsonencode({
    kind            = var.account_kind,
    sku             = {
      name      = "${var.account_tier}_${var.replication_type}"
    },
    properties      = {
      allowBlobPublicAccess = var.allow_public_blob_access,
      publicNetworkAccess   = var.networking_config.allow_public_access ? "Enabled" : "Disabled"
      networkAcls           = {
        bypass        = var.networking_config.bypass,
        defaultAction = var.networking_config.default_action
      }
    }
  })
}

resource azapi_resource_action listkeys {
  type                    = "Microsoft.Storage/storageAccounts@2022-09-01"
  resource_id             = azapi_resource.this.id
  action                  = "listKeys"
  response_export_values  = ["*"]
}

resource azapi_resource blobservices {
  count               = length(var.containers)

  type            = "Microsoft.Storage/storageAccounts/blobServices@2022-09-01"
  name            = var.containers[count.index].name
  parent_id       = "${azapi_resource.this.id}/blobServices/default"
}

resource azapi_resource fileshares {
  count               = length(var.file_shares)
  
  type            = "Microsoft.Storage/storageAccounts/fileServices/shares@2022-05-01"
  name            = var.file_shares[count.index].name
  parent_id       = "${azapi_resource.this.id}/fileservices/default"
}

resource azapi_resource queues {
  count           = length(var.queues)
  
  type            = "Microsoft.Storage/storageAccounts/queueServices/queues@2022-09-01"
  name            = var.queues[count.index].name
  parent_id       = "${azapi_resource.this.id}/queueServices/default"
}

resource azapi_resource tables {
  count           = length(var.tables)
  
  type            = "Microsoft.Storage/storageAccounts/tableServices/tables@2022-09-01"
  name            = var.tables[count.index].name
  parent_id       = "${azapi_resource.this.id}/tableServices/default"
}

#resource azurerm_role_assignment this {
#  count           = length(var.role_assignments)
#
#  scope                = azurerm_storage_account.sa.id
#  role_definition_name = var.role_assignments[count.index].role_definition_name
#  principal_id         = var.role_assignments[count.index].object_id
#}
