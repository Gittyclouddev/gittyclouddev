# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.70.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
    subscription_id    = "xxxxxx"
    client_id          = "xxxxxx"
    client_secret      = "xxxxxx"
    tenant_id          = "xxxxxx"
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "example" {
  name                        = var.keyvault_name
  resource_group_name         = azurerm_resource_group.example.name
  location                    = azurerm_resource_group.example.location
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
}

resource "azurerm_monitor_action_group" "example" {
  name                = var.action_group_name
  resource_group_name = azurerm_resource_group.example.name
  short_name          = var.action_group_short_name

  email_receiver {
    name          = var.email_receiver_name
    email_address = var.email_receiver_address
  }
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = var.diagnostic_setting_name
  target_resource_id = azurerm_key_vault.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id

  log {
    category = "AuditEvent"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  depends_on = [azurerm_log_analytics_workspace.example]
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_analytics_workspace_retention_days
}

resource "azurerm_monitor_activity_log_alert" "example" {
  name                = var.activity_log_alert_name
  resource_group_name = azurerm_resource_group.example.name
  scopes              = [azurerm_key_vault.example.id]

  criteria {
    category = "Administrative"
    level    = "Informational"

    operation {
      equals = "Microsoft.KeyVault/vaults/delete"
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.example.id
  }
}
