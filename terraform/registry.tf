# ---
# 6. Container Registry (ACR)
# ---

resource "azurerm_container_registry" "main" {
  # checkov:skip=CKV_AZURE_137: "Admin enabled required to pull images without Owner role assigned"
  # checkov:skip=CKV_AZURE_139: "Premium SKU too expensive for lab"
  # checkov:skip=CKV_AZURE_163: "Premium SKU required for retention"
  # checkov:skip=CKV_AZURE_164: "Premium SKU required for trust"
  # checkov:skip=CKV_AZURE_165: "Premium SKU required for geo-replication"
  # checkov:skip=CKV_AZURE_166: "Premium SKU required for public network access disable"
  # checkov:skip=CKV_AZURE_167: "Premium SKU required for dedicated data endpoints"

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
