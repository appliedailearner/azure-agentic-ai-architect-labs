#!/bin/bash
set -e

ENVIRONMENT=${1:-dev}
LOCATION=${2:-eastus}
RESOURCE_GROUP="rg-secure-ref-${ENVIRONMENT}"
WORKDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Deploying module 07 draft baseline"
echo "Environment: ${ENVIRONMENT}"
echo "Location: ${LOCATION}"
echo "Resource group: ${RESOURCE_GROUP}"

az group create --name "${RESOURCE_GROUP}" --location "${LOCATION}" --output none

az deployment group create \
  --resource-group "${RESOURCE_GROUP}" \
  --template-file "${WORKDIR}/../infra/main.bicep" \
  --parameters environment="${ENVIRONMENT}" location="${LOCATION}"

echo "Draft deployment complete."
