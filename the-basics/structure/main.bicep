// The param keyword, the name of the parameter and the parameter type (int)
param myparam int {
  default: 1
  minValue: 1
  maxValue: 10
  metadata: {
    description: 'Choose a number between 1 and 10'
  }
}

// The var keyword, the name of the variable and an expression. (note that the variable type is not required)
var myvar = myparam + 10

resource myresource 'Microsoft.Network/applicationSecurityGroups@2020-06-01' = {
  name: 'mynewresource'
  location: 'westeurope'
}
