[CmdletBinding()]
param (
    [Parameter()]
    [string] $Resourcegroupname,
    [string] $Bicepfile = ".\main.bicep",
    [string] $Parameterfile = ".\param.json",
    [switch] $WhatIf
)

$templatefile = $bicepfile -replace ".bicep", ".json"

bicep build $bicepfile

$params = @{
    resourcegroupname = $resourcegroupname
    templatefile      = $templatefile
}

if ($PSBoundParameters.Whatif) {
    New-AzResourceGroupDeployment @params -WhatIf
}
else {
    New-AzResourceGroupDeployment @params -Verbose -Force 
}