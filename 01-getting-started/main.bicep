resource myavailabilityset 'Microsoft.Compute/availabilitySets@2020-06-01' = {
  location: 'westeurope'
  name: 'myavset'
  properties: {
    platformFaultDomainCount: 3
    platformUpdateDomainCount: 5
  }
}