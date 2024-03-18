variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "keyvault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "The ID of the tenant"
  type        = string
}

variable "action_group_name" {
  description = "The name of the action group"
  type        = string
}

variable "action_group_short_name" {
  description = "The short name of the action group"
  type        = string
}

variable "email_receiver_name" {
  description = "The name of the email receiver"
  type        = string
}

variable "email_receiver_address" {
  description = "The email address of the receiver"
  type        = string
}

variable "diagnostic_setting_name" {
  description = "The name of the diagnostic setting"
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics workspace"
  type        = string
}

variable "log_analytics_workspace_sku" {
  description = "The SKU of the Log Analytics workspace"
  type        = string
}

variable "log_analytics_workspace_retention_days" {
  description = "The retention period for logs in the Log Analytics workspace (in days)"
  type        = number
}

variable "activity_log_alert_name" {
  description = "The name of the activity log alert"
  type        = string
}
