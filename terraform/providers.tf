terraform {
  required_version = ">= 1.5.0" # Force la derniere version stable

  backend "azurerm" {
    resource_group_name  = "rg-tfstate-backend"
    storage_account_name = "sttfstate3756"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90.0" # Fixe la version du provider (evite les updates cassees)
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false # Facilite le 'terraform destroy' pour les labs
    }
    key_vault {
      purge_soft_delete_on_destroy    = true # Detruit reellement le KV (evite le conflit de nom si tu rejoues)
      recover_soft_deleted_key_vaults = true
    }
  }
}
