# ---
# 4. Key Vault (Secrets Management)
# ---
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  # checkov:skip=CKV_AZURE_109: "Network ACLs break GitHub Actions without complex setup, omitted for lab"
  # checkov:skip=CKV_AZURE_189: "Private endpoints too expensive"

  name                        = "kv-${var.project_name}-${random_id.server_suffix.hex}"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true # Sécurité : Interdire les purges hâtives

  sku_name = "standard"

  tags = local.tags
}

resource "azurerm_key_vault_access_policy" "app_service" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_linux_web_app.main.identity[0].principal_id

  key_permissions    = ["Get", "List"]
  secret_permissions = ["Get", "List"]
}

resource "azurerm_key_vault_secret" "sql_password" {
  name            = "sql-admin-password"
  value           = random_password.sql_admin.result
  key_vault_id    = azurerm_key_vault.main.id
  content_type    = "text/plain"
  expiration_date = "2026-12-31T00:00:00Z"

  tags = local.tags
}

resource "azurerm_key_vault_secret" "sql_connection_string" {
  name            = "sql-connection-string"
  value           = "sqlserver://${azurerm_mssql_server.main.fully_qualified_domain_name}:1433;database=${azurerm_mssql_database.main.name};user=${var.sql_admin_login};password=${random_password.sql_admin.result};encrypt=true;trustServerCertificate=false"
  key_vault_id    = azurerm_key_vault.main.id
  content_type    = "text/plain"
  expiration_date = "2026-12-31T00:00:00Z"

  tags = local.tags
}
