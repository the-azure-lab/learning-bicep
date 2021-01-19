// start in a blank bicep file and press space. Use up/down arraows to select value and/or tab to move to the next field.

param location string = 'westeurope'
param name string = 'MYnsg001'

param tags object {
  default: {
    environment: 'dev'
  }
}

param securityRules array {
  default: []
}

var cleanname = toLower(name) // lowercase name of the nsg

resource mynsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: cleanname
  tags: tags
  location: location
  properties: {
    securityRules: securityRules
  }
}

// ctrl+alt+f to format.