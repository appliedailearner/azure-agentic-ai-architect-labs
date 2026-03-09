@description('Name of the target resource group')
param targetResourceGroupName string = resourceGroup().name

@description('Policy definition ID to assign')
param policyDefinitionId string

@description('Policy assignment display name')
param assignmentDisplayName string = 'Example policy assignment'

resource targetResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: targetResourceGroupName
}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: guid(targetResourceGroup.id, policyDefinitionId, assignmentDisplayName)
  scope: targetResourceGroup
  properties: {
    displayName: assignmentDisplayName
    policyDefinitionId: policyDefinitionId
    enforcementMode: 'Default'
  }
}
