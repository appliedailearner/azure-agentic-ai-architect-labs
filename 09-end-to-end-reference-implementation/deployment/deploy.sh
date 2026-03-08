#!/bin/bash
# Azure Agentic AI Reference Implementation Deployment Script
# This script deploys the complete infrastructure and application

set -e

echo "========================================"
echo "Azure Agentic AI Deployment"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
ENVIRONMENT=${1:-dev}
REGION=${2:-eastus}
PROJECT_NAME="agentic-ai"
WORKDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${YELLOW}Configuration:${NC}"
echo "  Environment: $ENVIRONMENT"
echo "  Region: $REGION"
echo "  Project: $PROJECT_NAME"
echo ""

# Check prerequisites
echo -e "${YELLOW}Checking prerequisites...${NC}"
command -v az >/dev/null 2>&1 || { echo -e "${RED}Azure CLI is required but not installed.${NC}"; exit 1; }
command -v terraform >/dev/null 2>&1 || { echo -e "${RED}Terraform is required but not installed.${NC}"; exit 1; }

echo -e "${GREEN}✓ Prerequisites OK${NC}"
echo ""

# Authenticate with Azure
echo -e "${YELLOW}Authenticating with Azure...${NC}"
az login --use-device-code

echo -e "${GREEN}✓ Authentication successful${NC}"
echo ""

# Initialize Terraform
echo -e "${YELLOW}Initializing Terraform...${NC}"
cd "$WORKDIR/../infra"
terraform init -upgrade

echo -e "${GREEN}✓ Terraform initialized${NC}"
echo ""

# Plan deployment
echo -e "${YELLOW}Planning infrastructure changes...${NC}"
terraform plan \
  -var="environment=$ENVIRONMENT" \
  -var="location=$REGION" \
  -var="project_name=$PROJECT_NAME" \
  -out="tfplan"

echo ""
read -p "Do you want to proceed with deployment? (yes/no) " -n 3 -r
echo ""
if [[ ! $REPLY =~ ^yes$ ]]; then
  echo -e "${YELLOW}Deployment cancelled${NC}"
  exit 0
fi

echo ""
echo -e "${YELLOW}Applying infrastructure...${NC}"
terraform apply "tfplan"

echo -e "${GREEN}✓ Infrastructure deployed successfully${NC}"
echo ""

# Get outputs
echo -e "${YELLOW}Retrieving outputs...${NC}"
OPENAI_ENDPOINT=$(terraform output -raw openai_endpoint)
SEARCH_ENDPOINT=$(terraform output -raw search_endpoint)
KEYVAULT_URI=$(terraform output -raw key_vault_uri)
RESOURCE_GROUP=$(terraform output -raw resource_group_name)

echo -e "${GREEN}Deployment Complete${NC}"
echo ""
echo "Important Endpoints:"
echo "  OpenAI Endpoint: $OPENAI_ENDPOINT"
echo "  Search Endpoint: $SEARCH_ENDPOINT"
echo "  Key Vault URI: $KEYVAULT_URI"
echo "  Resource Group: $RESOURCE_GROUP"
echo ""
echo "Next Steps:"
echo "  1. Configure your .env file with the endpoints above"
echo "  2. Deploy the Python application"
echo "  3. Set up GitHub Actions workflows"
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}For more details, see DEPLOYMENT-GUIDE.md${NC}"
echo -e "${GREEN}========================================${NC}"
