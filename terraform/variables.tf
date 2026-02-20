variable "project_name" {
  description = "A unique name for this project"
  type        = string
  default     = "projet1"
}

variable "environment" {
  description = "Execution environment (dev, prod, staging)"
  type        = string
  default     = "lab"
}

variable "location" {
  description = "Azure Region for all resources"
  type        = string
  default     = "France Central"
}

variable "sql_admin_login" {
  description = "Administrator username for the SQL Server"
  type        = string
  default     = "adminuser"
}

variable "db_sku_name" {
  description = "SKU for the SQL Database (Keep 'Basic' for lowest cost)"
  type        = string
  default     = "Basic"
}

variable "app_service_sku" {
  description = "SKU for the App Service Plan (F1 for Free, B1 for reliable Dev)"
  type        = string
  default     = "B1"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Owner       = "Damien"
    Project     = "CloudEngineer-Step1"
    Environment = "Lab"
    Terraform   = "True"
  }
}

variable "alert_email" {
  description = "Email address for monitoring alerts"
  type        = string
}


