# Learning Bicep

Azure Bicep is a new declarative Domain Specific Language (DSL) for deploying Azure resources.
The ultimate goal and the driver behind the Bicep project is a need to make it easier to write Infrastructure as Code (IaC) for the Azure platform.

Azure Bicep works as a transparent abstraction layer on top of ARM templates. Anything that can be done with ARM Templates can be done with Azure Bicep.
With this abstraction, all the types, apiVersions, and properties that are valid within ARM Templates are also automatically valid with Azure Bicep.

The Azure Bicep code is converted into an ARM Template. Then, the resulting ARM Template is used to deploy the Azure resources.
From a tooling perspective the target it that you will be able to deploy bicep files directly using the standard Az Cli or Az powershell deploy commands.

This repo contains everything you need to know to master bicep deployments.

Here are the modules I have currently written. I would recommend to look at these in the order below, but if you are already familiar with some of the topics you could just jump around. Let me know if there are specific topics missing that you would have liked to see covered in a video.  

- Chapter 1: [Getting started](https://github.com/the-azure-lab/learning-bicep/blob/main/getting-started/README.md)
    - Installation, container setup, vscode
- Chapter 2: [Basics](https://github.com/the-azure-lab/learning-bicep/blob/main/basics/README.md)
    - Resources, parameters, variables, outputs
- Chapter 3: [Conditions](https://github.com/the-azure-lab/learning-bicep/blob/main/conditions/README.md)
- Chapter 4: [Loops](https://github.com/the-azure-lab/learning-bicep/blob/main/loops/README.md)
- Chapter 5: [Functions](https://github.com/the-azure-lab/learning-bicep/blob/main/functions/README.md)
- Chapter 6: [Modules](https://github.com/the-azure-lab/learning-bicep/blob/main/modules/README.md)
- Chapter 7: [Putting it all together](https://github.com/the-azure-lab/learning-bicep/blob/main/putting-it-all-together/README.md)
- Chapter 8: [Learning bicep by examples](https://github.com/the-azure-lab/learning-bicep/blob/main/bicep-examples/README.md)
- [The Azure bicep modules library](https://github.com/the-azure-lab/learning-bicep/blob/main/modules-library/README.md)
