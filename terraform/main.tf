# Local variables for resource naming convention
locals {
  resource_group_name = "rg-${var.project_name}-${var.environment}"
  location            = var.location
  tags = merge(var.tags, {
    "ManagedBy" = "GitHubActions"
    "Trigger"   = "ReDeploy"
  })
}

# ---
# 1. Resource Group
# ---
resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}
