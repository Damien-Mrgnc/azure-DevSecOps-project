# ---
# 5. Compute (App Service)
# ---
resource "azurerm_service_plan" "main" {
  name                = "asp-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku

  tags = local.tags
}

resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.project_name}-${random_id.server_suffix.hex}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      # Initial image (hello world), will be overwritten by CI/CD
      docker_image_name   = "nginxdemos/hello:latest"
      docker_registry_url = "https://index.docker.io"
    }
    always_on        = true # Recommended for B1.
    app_command_line = "npm start"
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    # Internal port for Node.js application
    "WEBSITES_PORT" = "8080"
    "PORT"          = "8080"
    "NODE_ENV"      = "production"

    # ACR Credentials (Fallback for when Role Assignment fails)
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${azurerm_container_registry.main.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.main.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.main.admin_password

    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.main.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.main.connection_string

    # Key Vault Integration
    "KEY_VAULT_URL" = azurerm_key_vault.main.vault_uri


    # Database Connection String with Key Vault Reference for Password
    # Format: sqlserver://<server>;database=<db>;user=<user>;password=@Microsoft.KeyVault(...);encrypt=true
    "DATABASE_URL" = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.sql_connection_string.versionless_id})"
  }

  lifecycle {
    ignore_changes = [
      site_config[0].application_stack[0].docker_image_name,
      tags,
      auth_settings_v2,
      auth_settings
    ]
  }

  tags = local.tags
}
