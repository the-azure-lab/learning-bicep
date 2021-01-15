# Learning Bicep

Azure Bicep is a new declarative Domain Specific Language (DSL) for deploying Azure resources.
The ultimate goal and the driver behind the Bicep project is a need to make it easier to write Infrastructure as Code (IaC) for the Azure platform.

Azure Bicep works as a transparent abstraction layer on top of ARM templates. Anything that can be done with ARM Templates can be done with Azure Bicep. 
With this abstraction, all the types, apiVersions, and properties that are valid within ARM Templates are also automatically valid with Azure Bicep.

The Azure Bicep code is converted into an ARM Template. Then, the resulting ARM Template is used to deploy the Azure resources. 
From a tooling perspective the target it that you will be able to deploy bicep files directly using the standard Az Cli or Az powershell deploy commands. 

This repo contains everything you need to know to master bicep deployments.

Here are the modules I have currently written. I would recommend to look at these in the order below, but if you are already familiar with some of the topics you could just jump around. Let me know if there are specific topics missing that you would have liked to see covered in a video.  

- Chapter 1: Getting started
- Chapter 2: The basics
- Chapter 3: Modules
- Chapter 4: Putting it all together
- Chapter 5: The examples
- Extra: The modules library
