
#Create KeyVault ID
resource "random_id" "kvname" {
  byte_length = 5
  prefix      = "keyvault"
}

# Access the configuration of the AzureRM provider
data "azurerm_client_config" "current" {}


resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-${var.service}-rg"
  location = var.location

  tags = var.default_tags
}

resource "azurerm_key_vault" "this" {
  name                            = random_id.kvname.hex
  location                        = azurerm_resource_group.this.location
  resource_group_name             = azurerm_resource_group.this.name
  enabled_for_disk_encryption     = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false

  sku_name = "standard"

  tags = var.default_tags
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}