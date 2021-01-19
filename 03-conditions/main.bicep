
// Condition - Example 1 - using a simple true/false condition
param name1 string = 'mynsg001'
param createNsg bool = true

resource mynsg1 'Microsoft.Network/networkSecurityGroups@2020-06-01' = if (createNsg) {
  name: 'mynsg1'
  location: 'westeurope'
  properties: {
    securityRules: []
  }
}

// Condition - Example 2 - using an expression/function
param name2 string = 'mynsg2'

resource mynsg2 'Microsoft.Network/networkSecurityGroups@2020-06-01' = if (createNsg && (name2 != '') ) {
  name: 'mynsg2'
  location: 'westeurope'
  properties: {
    securityRules: []
  }
}

// set the subscription context where you want to deploy i.e using set-azcontext.
// $rgname = "bicep-demo"
// New-AzResourceGroupDeployment -ResourceGroupName $rgname -TemplateFile ./main.json
// Get-AzNetworkSecurityGroup -ResourceGroupName $gname | ft name
