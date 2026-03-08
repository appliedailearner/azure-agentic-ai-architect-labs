# Terraform Variables for Azure Agentic AI Reference Implementation

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "eastus"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "agentic-ai"
}

variable "search_sku" {
  description = "Azure Search service SKU"
  type        = string
  default     = "standard"
  
  validation {
    condition     = contains(["free", "basic", "standard", "standard2", "standard3"], var.search_sku)
    error_message = "Search SKU must be free, basic, standard, standard2, or standard3."
  }
}

variable "openai_model" {
  description = "OpenAI model deployment name"
  type        = string
  default     = "gpt-4"
}

variable "openai_model_version" {
  description = "OpenAI model version"
  type        = string
  default     = "0125-preview"
}

variable "cosmosdb_throughput" {
  description = "Cosmos DB provisioned throughput (RU/s)"
  type        = number
  default     = 400

  validation {
    condition     = var.cosmosdb_throughput >= 100 && var.cosmosdb_throughput <= 1000000
    error_message = "Throughput must be between 100 and 1,000,000 RU/s."
  }
}

variable "enable_vnet_integration" {
  description = "Enable Virtual Network integration for services"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}
