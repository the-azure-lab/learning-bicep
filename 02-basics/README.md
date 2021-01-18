# Bicep basics

Azure Bicep is a declarative Domain Specific Language (DSL) for deploying Azure resources.
The ultimate goal and the main motivation behind Bicep is to make it easier to write Infrastructure as Code (IaC) for the Azure platform (removing some of the barriers of using current ARM templates).

Azure Bicep works as a transparent abstraction layer on top of ARM templates. Anything that can be done with ARM Templates can be done with Azure Bicep. With this abstraction, all the types, apiVersions, and properties that are valid within ARM Templates are also automatically valid with Azure Bicep.

Bicep code is converted to an ARM Template. The resulting ARM Template (JSON) is then sent to the Azure Resource Manager to deploy the resources (normally in a single API call).

From a tooling perspective bicep files will eventually (most likely) be directly deployable using Azure CLI or Az powershell deploy commands (used for deploying ARM templates).

![Bicep DSL](https://github.com/the-azure-lab/learning-bicep/blob/main/.images/azure-bicep-highlevel.png)

## Learning objectives

- Resources (resources)
- Parameters (param)
- Variables (var)
- Outputs (output)
- [Using the VScode extension](../from-scratch/README.md)

If you haven't already, follow [these instructions](../01-getting-started/README.md) to install the bicep CLI and VS Code extension.

## Adding resources

Create a main.bicep file and paste in the section below. Now you have added your first `resource` to your bicep file -- a basic network security group (with only default rules). This is a free Azure resource that can be deployed without any cost.

```yml
resource mynsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: 'mynsg001'
  location: 'westeurope'
  properties: {
    securityRules: []
  }
}
```

The resource declaration above has four components:

- The `resource` keyword
- A **symbolic name** (`mynsg`) - this is the identifier when referencing this resource in the bicep file. It's *not* the name of the resource in Azure.
- **type** (`Microsoft.Network/networkSecurityGroups@2020-06-01`) - has three parts: the resource provider (`Microsoft.Network`), the resource type (`networkSecurityGroups`), and the apiVersion (`2020-06-01`).
- **properties** (everything inside `= {...}`) - these are the properties for the given resource type. These are *exactly* the same properties that are available in the ARM Template.

When you compile the template with `bicep build main.bicep`, you should see the following JSON:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "functions": [],
  "resources": [
    {
      "type": "Microsoft.Network/networkSecurityGroups",
      "apiVersion": "2020-06-01",
      "name": "mynsg001",
      "location": "westeurope",
      "properties": {
        "securityRules": []
      }
    }
  ]
}
```

Now you can deploy this template using any standard command line tools for deployment of ARM templates. (`az deployment group create ...` or `New-AzResourceGroupDeployment ...`).

## Adding parameters and variables

In most cases, it is a good idea to expose values as parameters, so we can add the following:

```yaml
param location string = 'westeurope'
param name string = 'mynsg001'

param tags object {
  default: {
    environment: 'dev'
  }
}

param securityRules array {
  default: []
}

resource mynsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: name
  tags: tags
  location: location
  properties: {
    securityRules: securityRules
  }
}
```

Notice the `parameters` can be referenced directly via their name in bicep, compared to requiring `[parameters('location')]` in ARM template JSON.

The end of the parameter declarations (`= 'westeurope', = 'mynsg001'`) are the *default* value of the parameter. These can be optionally overridden at deployment time or using a parameter file (currently a standard ARM parameter file must be used for this).

When you compile with `bicep build main.bicep` you should get output similar to the below JSON:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "location": {
      "type": "string",
      "defaultValue": "westeurope"
    },
    "name": {
      "type": "string",
      "defaultValue": "mynsg001"
    },
    "tags": {
      "type": "object",
      "defaultValue": {
        "environment": "dev"
      }
    },
    "securityRules": {
      "type": "array",
      "defaultValue": []
    }
  },
  "functions": [],
  "resources": [
    {
      "type": "Microsoft.Network/networkSecurityGroups",
      "apiVersion": "2020-06-01",
      "name": "[parameters('name')]",
      "tags": "[parameters('tags')]",
      "location": "[parameters('location')]",
      "properties": {
        "securityRules": "[parameters('securityRules')]"
      }
    }
  ]
}
```

## Adding variables and outputs

You can also add `variables` for storing values or complex expressions, and emit `outputs` to be passed to a script or another template:

```yaml
param location string = 'westeurope'
param name string = 'mynsg001'
param tags object {
  default: {
    environment: 'dev'
  }
}
param securityRules array {
  default: []
}

var cleanname = toLower(name)  // lowercase the name of the nsg

resource mynsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: cleanname
  tags: tags
  location: location
  properties: {
    securityRules: securityRules
  }
}

output nsgid string = mynsg.id  // the resourceId of the NSG
```

Notice that you can easily reference the resource `Id` from the symbolic name of the network security group (`mynsg.id`) which we will translate to the `resourceId(...)` function in the compiled template. When compiled, you should see the following ARM Template JSON:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "location": {
      "type": "string",
      "defaultValue": "westeurope"
    },
    "name": {
      "type": "string",
      "defaultValue": "mynsg001"
    },
    "tags": {
      "type": "object",
      "defaultValue": {
        "environment": "dev"
      }
    },
    "securityRules": {
      "type": "array",
      "defaultValue": []
    }
  },
  "functions": [],
  "variables": {
    "cleanname": "[toLower(parameters('name'))]"
  },
  "resources": [
    {
      "type": "Microsoft.Network/networkSecurityGroups",
      "apiVersion": "2020-06-01",
      "name": "[variables('cleanname')]",
      "tags": "[parameters('tags')]",
      "location": "[parameters('location')]",
      "properties": {
        "securityRules": "[parameters('securityRules')]"
      }
    }
  ],
  "outputs": {
    "nsgid": {
      "type": "string",
      "value": "[resourceId('Microsoft.Network/networkSecurityGroups', variables('cleanname'))]"
    }
  }
}
```
