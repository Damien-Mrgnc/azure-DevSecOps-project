# ---
# 6. Container Registry (ACR)
# ---

resource "azurerm_container_registry" "main" {
  name                = "acr${var.project_name}${random_id.server_suffix.hex}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true # Useful for local debugging / admin user

  tags = local.tags
}

# ---
# Role Assignment: Allow App Service to Pull Images
# REMOVED: Requires 'Owner' or 'User Access Administrator' permissions which the SP might not have.
# We will use ACR Admin Credentials in compute.tf instead.
# ---
