# Bicep from scratch using the VSCode extension

The vscode extension makes it easy to write bicep files from scratch.

Inside your main.bicep file press `space`. This should bring you a list of allowed keywords and declaration in your current context.
Try to add the resource template declaration. It should look similar to the below.

![vscode-add-template-resource](https://github.com/the-azure-lab/learning-bicep/blob/main/.images/vscode-plugin-add-resource.png)

Verify the bicep template.

```powershell
bicep build .\main.bicep
$rgname = "bicep-demo"  
New-AzResourceGroupDeployment -ResourceGroupName $rgname -TemplateFile ./main.json
Get-AzNetworkSecurityGroup -ResourceGroupName $rgname | Format-Table ResourceGroupName,Name
```
