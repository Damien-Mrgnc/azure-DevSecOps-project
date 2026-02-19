output "resource_group_name" {
  description = "Name of the created Resource Group"
  value       = azurerm_resource_group.main.name
}

output "web_app_url" {
  description = "Main URL of the deployed Web App"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "web_app_name" {
  description = "Name of the Azure Web App"
  value       = azurerm_linux_web_app.main.name
}

output "sql_server_fqdn" {
  description = "Fully Qualified Domain Name of the SQL Server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "key_vault_name" {
  description = "Name of the Key Vault storing secrets"
  value       = azurerm_key_vault.main.name
}

output "acr_login_server" {
  description = "The login server for the Azure Container Registry"
  value       = azurerm_container_registry.main.login_server
}

output "acr_admin_username" {
  description = "The admin username for the ACR"
  value       = azurerm_container_registry.main.admin_username
}

output "acr_admin_password" {
  description = "The admin password for the ACR"
  sensitive   = true
  value       = azurerm_container_registry.main.admin_password
}

# For debug/dev only - Never output secrets in clear text in Prod!
output "sql_admin_password_secret_id" {
  description = "ID of the Key Vault Secret containing the SQL password"
  value       = azurerm_key_vault_secret.sql_password.id
}
