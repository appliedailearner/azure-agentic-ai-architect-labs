@description('Target resource group name for the role assignment')
param targetResourceGroupName string = resourceGroup().name

@description('Principal ID to assign the role to')
param principalId string

@description('Built-in role definition GUID')
param roleDefinitionGuid string

resource targetResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: targetResourceGroupName
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(targetResourceGroup.id, principalId, roleDefinitionGuid)
  scope: targetResourceGroup
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionGuid)
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}
