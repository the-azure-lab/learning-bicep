# Bicep basics

Azure Bicep is a declarative Domain Specific Language (DSL) for deploying Azure resources.
The ultimate goal and the main motivation behind Bicep is to make it easier to write Infrastructure as Code (IaC) for the Azure platform (removing some of the barriers of writing IaC using ARM templates). 

Azure Bicep works as a transparent abstraction layer on top of ARM templates. Anything that can be done with ARM Templates can be done with Azure Bicep. With this abstraction, all the types, apiVersions, and properties that are valid within ARM Templates are also automatically valid with Azure Bicep.

Bicep code is converted to an ARM Template. The resulting ARM Template (JSON) is then sent to the Azure Resource Manager to deploy the resources (normally in a single API call).

From a tooling perspective bicep files will eventually (most likely) be directly deployable using Azure CLI or Az powershell deploy commands (used for deploying ARM templates).

![Bicep DSL](https://github.com/the-azure-lab/learning-bicep/blob/main/.images/azure-bicep-highlevel.png)

## Basic bicep elements

Bicep only have a few main elements. If you understand these you will pretty soon master bicep development. (if you are familiar with ARM templates the concepts  should already be familiar).

#### Learning objectives: 

- Parameters (param)
- Variables (var)
- Resources (resources)
- Outputs (output)
- Loops
- Conditions
- Functions
- Modules

If you have the bicep VScode extension installed and your bicep file is called *.bicep then Language Engine will give you all the nice features that are really helpfull when creating bicep files.

### Resources

A bicep `resource` is simply the resource (i.e VM, NSG, AKS) you are planning to deploy to Azure. 

### Parameters and variables

A bicep `param` is the method to provide input to a bicep deployment i.e to change the behaviour of the deployment. 

- Variables related to a specific resource can be defined close to that resource in the bicep file.
- Variables can be defined anywhere in the bicep file. 

Types available are: 

- bool
- int
- string
- array
- object
