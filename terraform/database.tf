# ---
# 3. Database (Azure SQL)
# ---
resource "random_password" "sql_admin" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_id" "server_suffix" {
  byte_length = 5
}

resource "azurerm_mssql_server" "main" {
  # checkov:skip=CKV_AZURE_23: "Auditing requires Storage Account, omitted for lab"
  # checkov:skip=CKV_AZURE_24: "Auditing retention omitted for lab"
  # checkov:skip=CKV_AZURE_25: "Vulnerability Assessment requires Defender ($15/mo), omitted for lab"
  # checkov:skip=CKV_AZURE_68: "Private endpoint is too expensive for lab"
  # checkov:skip=CKV_AZURE_113: "Public network access needed since 0.0.0.0 removed"

  name                         = "sql-${var.project_name}-${random_id.server_suffix.hex}"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = random_password.sql_admin.result
  minimum_tls_version          = "1.2" # Best Practice Security

  azuread_administrator {
    login_username = "azureadadmin"
    object_id      = data.azurerm_client_config.current.object_id
  }

  tags = local.tags
}

resource "azurerm_mssql_database" "main" {
  # checkov:skip=CKV_AZURE_224: "Ledger requires specific SKUs, omitted for lab"

  name        = "sqldb-${var.project_name}"
  server_id   = azurerm_mssql_server.main.id
  sku_name    = var.db_sku_name
  max_size_gb = 2

  tags = local.tags
}

