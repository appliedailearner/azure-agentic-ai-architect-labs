targetScope = 'resourceGroup'

@description('Deployment location')
param location string = resourceGroup().location

@description('Environment name')
@allowed([
  'dev'
  'test'
  'prod'
])
param environment string = 'dev'

@description('Project name prefix')
param projectName string = 'rag-search'

var resourceSuffix = '${projectName}-${environment}'

resource searchService 'Microsoft.Search/searchServices@2023-11-01' = {
  name: 'search-${resourceSuffix}'
  location: location
  sku: {
    name: environment == 'prod' ? 'standard' : 'basic'
  }
  properties: {
    publicNetworkAccess: 'enabled'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'plan-${resourceSuffix}'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: 'app-${resourceSuffix}'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.11'
      minTlsVersion: '1.2'
    }
    httpsOnly: true
  }
}

output searchServiceName string = searchService.name
output webAppName string = webApp.name
