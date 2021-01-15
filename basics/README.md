# Bicep basics

Azure Bicep is a new declarative Domain Specific Language (DSL) for deploying Azure resources.
The ultimate goal and the driver behind the Bicep project is a need to make it easier to write Infrastructure as Code (IaC) for the Azure platform.

Azure Bicep works as a transparent abstraction layer on top of ARM templates. Anything that can be done with ARM Templates can be done with Azure Bicep.
With this abstraction, all the types, apiVersions, and properties that are valid within ARM Templates are also automatically valid with Azure Bicep.

The Azure Bicep code is converted into an ARM Template. Then, the resulting ARM Template is used to deploy the Azure resources.
From a tooling perspective the target it that you will be able to deploy bicep files directly using the standard Az Cli or Az powershell deploy commands.

[Bicep DSL](https://github.com/the-azure-lab/learning-bicep/.images/azure-bicep-highlevel.png)

## Basic bicep elements

bicep has some basic elements that you need to understand. If you get these you will pretty soon master bicep development.

- Parameters
- Variables
- Resources
- Outputs
- Loops
- Conditions
- Functions
- Modules

If you have the bicep VScode extension installed and your bicep file is called *.bicep then Language Engine will give you all the nice features that are really helpfull when creating bicep files.
