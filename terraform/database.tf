# ---
# 3. Database (Azure SQL)
# ---
resource "random_password" "sql_admin" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_id" "server_suffix" {
  byte_length = 4
}

resource "azurerm_mssql_server" "main" {
  name                         = "sql-${var.project_name}-${random_id.server_suffix.hex}"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = random_password.sql_admin.result
  minimum_tls_version          = "1.2" # Best Practice Security

  tags = local.tags
}

resource "azurerm_mssql_database" "main" {
  name        = "sqldb-${var.project_name}"
  server_id   = azurerm_mssql_server.main.id
  sku_name    = var.db_sku_name
  max_size_gb = 2

  tags = local.tags
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0" # "Allow Azure Services" magic IP
}
