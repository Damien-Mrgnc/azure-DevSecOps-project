# ---
# 5. Compute (App Service)
# ---
resource "azurerm_service_plan" "main" {
  # checkov:skip=CKV_AZURE_212: "Zone redundancy too expensive for this lab ASP"
  # checkov:skip=CKV_AZURE_225: "Production SKU P1v3 too expensive for lab"
  # checkov:skip=CKV_AZURE_211: "Multiple instances too expensive for lab"

  name                = "asp-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku

  tags = local.tags
}

resource "azurerm_linux_web_app" "main" {
  name                    = "app-${var.project_name}-${random_id.server_suffix.hex}"
  resource_group_name     = azurerm_resource_group.main.name
  location                = azurerm_service_plan.main.location
  service_plan_id         = azurerm_service_plan.main.id
  https_only              = true
  client_affinity_enabled = false

  # Risk Acceptance for Lab:
  # checkov:skip=CKV_AZURE_13: "App Service Auth requires Entra ID application, keeping simple for lab"
  # checkov:skip=CKV_AZURE_222: "Private Endpoints are too expensive for this lab"
  # checkov:skip=CKV_AZURE_113: "Public network access required absent Private Endpoints"
  # checkov:skip=CKV_AZURE_88: "Storage account mounting not used"
  # checkov:skip=CKV_AZURE_14: "Client cert auth not needed"
  # checkov:skip=CKV_AZURE_17: "Client affinity not needed"
  # checkov:skip=CKV_AZURE_213: "Managed Identity already configured via identity block"
  # checkov:skip=CKV_AZURE_65: "Access restrictions are skipped for lab portal"
  # checkov:skip=CKV_AZURE_71: "Managed identity used instead of basic auth"
  # checkov:skip=CKV_AZURE_78: "Client certs not needed"

  site_config {
    application_stack {
      # Initial image (hello world), will be overwritten by CI/CD
      docker_image_name   = "nginxdemos/hello:latest"
      docker_registry_url = "https://index.docker.io"
    }
    app_command_line    = "npm start"
    always_on           = true # Recommended for B1.
    ftps_state          = "Disabled"
    http2_enabled       = true
    minimum_tls_version = "1.2"
    health_check_path   = "/"

    ip_restriction {
      name       = "AllowAny"
      priority   = 100
      action     = "Allow"
      ip_address = "0.0.0.0/0"
    }
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
    failed_request_tracing  = true
    detailed_error_messages = true
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    # Internal port for Node.js application
    "WEBSITES_PORT" = "8080"
    "PORT"          = "8080"
    "NODE_ENV"      = "production"

    # ACR Credentials (Identity Based - Requires AcrPull Role Assigned to SystemIdentity)
    "DOCKER_REGISTRY_SERVER_URL" = "https://${azurerm_container_registry.main.login_server}"

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
