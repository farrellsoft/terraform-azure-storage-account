
output storage_account {
  value = {
    id      = azapi_resource.this.id
    name    = azapi_resource.this.name
  }
}

output access_key {
  value     = jsondecode(azapi_resource_action.listkeys.output).keys[0].value
  sensitive = true
}
#
#output connection_string {
#  value     = azurerm_storage_account.sa.primary_connection_string
#  sensitive = true
#}
#
#output file_shares {
#  value     = [for share in module.file-shares: share.share_name]
#}