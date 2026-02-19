# ---
# 7. Alerting (Action Groups & Metric Alerts)
# ---

# 1. Action Group (Who to notify)
resource "azurerm_monitor_action_group" "main" {
  name                = "ag-${var.project_name}"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "p1-alerts"

  email_receiver {
    name                    = "admin-email"
    email_address           = var.alert_email
    use_common_alert_schema = true
  }

  tags = local.tags
}

# 2. App Service Plan - High CPU Alert (>80%)
resource "azurerm_monitor_metric_alert" "asp_cpu" {
  name                = "alert-asp-cpu-high"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_service_plan.main.id]
  description         = "Action will be triggered when CPU percentage is greater than 80."

  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
    metric_name      = "CpuPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  tags = local.tags
}

# 3. Web App - Service Unavailable (HTTP 5xx)
resource "azurerm_monitor_metric_alert" "app_http_5xx" {
  name                = "alert-webapp-5xx"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_web_app.main.id]
  description         = "Action will be triggered when HTTP 5xx errors occur."

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 5
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  tags = local.tags
}

# 4. SQL Database - Low Storage Space
resource "azurerm_monitor_metric_alert" "sql_storage" {
  name                = "alert-sql-storage-low"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_mssql_database.main.id]
  description         = "Action will be triggered when SQL storage usage is high."

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "storage_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  tags = local.tags
}
