# Main Terraform Configuration for Azure Agentic AI Reference Implementation
# This file orchestrates the deployment of all core infrastructure components

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.70"
    }
  }

  # Backend configuration for state management
  # Uncomment and configure for production deployments
  # backend "azurerm" {
  #   resource_group_name  = "terraform-state"
  #   storage_account_name = "terraformstate"
  #   container_name       = "tfstate"
  #   key                  = "prod.tfstate"
  # }
}

provider "azurerm" {
  features {}
}

# Local values for consistent naming and tagging
locals {
  environment     = var.environment
  location        = var.location
  project_name    = var.project_name
  resource_suffix = "${local.project_name}-${local.environment}"

  common_tags = {
    Environment = local.environment
    Project     = local.project_name
    ManagedBy   = "Terraform"
    CreatedDate = timestamp()
  }
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.resource_suffix}"
  location = local.location
  tags     = local.common_tags
}

# Azure AI Foundry Hub
resource "azurerm_ai_services" "hub" {
  name                = "aih-${local.resource_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "AIServices"
  sku_name            = "S0"

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}

# Azure OpenAI Deployment
resource "azurerm_cognitive_account" "openai" {
  name                = "oai-${local.resource_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "OpenAI"
  sku_name            = "S0"

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}

# Azure Search Service for RAG
resource "azurerm_search_service" "search" {
  name                = "search-${local.resource_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.search_sku

  public_network_access_enabled = true

  tags = local.common_tags
}

# Azure Cosmos DB for agent state
resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "cosmos-${local.resource_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0
  }

  depends_on = [azurerm_resource_group.rg]

  tags = local.common_tags
}

# Key Vault for secrets management
resource "azurerm_key_vault" "kv" {
  name                = "kv-${local.resource_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  purge_protection_enabled = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
    ]
  }

  tags = local.common_tags
}

# Store OpenAI key in Key Vault
resource "azurerm_key_vault_secret" "openai_key" {
  name         = "openai-api-key"
  value        = azurerm_cognitive_account.openai.primary_access_key
  key_vault_id = azurerm_key_vault.kv.id
}

# Store Search key in Key Vault
resource "azurerm_key_vault_secret" "search_key" {
  name         = "search-api-key"
  value        = azurerm_search_service.search.primary_access_key
  key_vault_id = azurerm_key_vault.kv.id
}

# Data source for current Azure context
data "azurerm_client_config" "current" {}

# Module outputs
output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Name of the created resource group"
}

output "openai_endpoint" {
  value       = azurerm_cognitive_account.openai.endpoint
  description = "Azure OpenAI endpoint"
}

output "search_endpoint" {
  value       = "https://${azurerm_search_service.search.name}.search.windows.net"
  description = "Azure Search endpoint"
}

output "cosmosdb_endpoint" {
  value       = azurerm_cosmosdb_account.cosmosdb.endpoint
  description = "Cosmos DB endpoint"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "Key Vault URI"
}
