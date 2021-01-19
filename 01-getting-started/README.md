# Getting started with bicep in 1-2-3

You want to get started playing around with bicep, but you are not sure where to start?

## Learning objectives

- Install the bicep CLI and the VSCode plugin.
- Compile and deploy the first bicep file
- Run bicep from a container

## Step 1: Install the bicep CLI

The first thing you need to do, is to install the bicep CLI. Based on your preference you can install this directly to your local computer, or you can install it in a container. We will revisit how you can easily use bicep in a container.

### Install bicep locally

If you prefer to have bicep installed directly on your machine run the set of Windows or Linux commands below (or run the install.ps1 script located in this folder).

On Windows:

```powershell
# Create the install folder
$installPath = "$env:USERPROFILE\.bicep"
$installDir = New-Item -ItemType Directory -Path $installPath -Force
$installDir.Attributes += 'Hidden'

# Fetch the latest Bicep CLI binary
(New-Object Net.WebClient).DownloadFile("https://github.com/Azure/bicep/releases/latest/download/bicep-win-x64.exe", "$installPath\bicep.exe")

# Add bicep to your PATH
$currentPath = (Get-Item -path "HKCU:\Environment" ).GetValue('Path', '', 'DoNotExpandEnvironmentNames')
if (-not $currentPath.Contains("%USERPROFILE%\.bicep")) { setx PATH ($currentPath + ";%USERPROFILE%\.bicep") }
if (-not $env:path.Contains($installPath)) { $env:path += ";$installPath" }

# Verify you can now access the 'bicep' command.
bicep --help

```

On Linux:

```sh
# Install bicep
sudo curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
sudo chmod +x ./bicep \
sudo mv ./bicep /usr/local/bin/bicep
```

### Install bicep in a container (do deployments from inside the container)

If you do not want to install stuff directly on your host you can do all of the excercises below in a container (it requires that you have i.e Docker Desktop installed and running). This is a good choice if you want to have a separation between your dev projects and software installed on your machine as it makes it easier to clean up afterwards.

```powershell
# download the image and start a container
docker run -it --rm -v ${HOME}:/root/ -v ${PWD}:/work -w /work --net host ubuntu:18.04 bash
```

Inside the container you run the comands below to install bicep and the az cli.

```sh
# Install curl & required libraries
apt-get update && apt-get install -y curl libcurl4 libicu60 libunwind8 libssl1.0

# Install the Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install bicep
curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
chmod +x ./bicep
mv ./bicep /usr/local/bin/bicep

# Check versions
bicep --version
```

For more information on working from a container with bicep please check out the [learning-bicep/docker-container/README.md](https://github.com/the-azure-lab/learning-bicep/blob/main/docker-container/README.md).

## Step 2: Get the bicep VSCode plugin

The second thing you need to do to get started is to get the bicep VSCode plugin. This will give you the intellisense, code completion and the formatting you need to get started. This is a must.

- Go to extensions in VScode and search for bicep.
- Install the latest release of the Bicep extension.

## Step 3: Verify that bicep is working

Creat a file called main.bicep and add the content below.

```yaml
resource myavailabilityset 'Microsoft.Compute/availabilitySets@2020-06-01' = {
  location: 'westeurope'
  name: 'myavset'
  properties: {
    platformFaultDomainCount: 5
    platformUpdateDomainCount: 2
  }
}
```

Run the following command.

```powershell
bicep build main.bicep
```
The main.bicep file should compile without errors and you should now see a `main.json` file in your folder. This is the JSON template that will be sent to the Azure Resource Manager API.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "functions": [],
  "resources": [
    {
      "type": "Microsoft.Compute/availabilitySets",
      "apiVersion": "2020-06-01",
      "location": "westeurope",
      "name": "myavset",
      "properties": {
        "platformFaultDomainCount": 5,
        "platformUpdateDomainCount": 2
      }
    }
  ]
}
```

Deploy the template (directly from the github repo).

```sh
$rgname='bicep-demo'
az deployment group create --resource-group $RGNAME --template-uri https://github.com/the-azure-lab/learning-bicep/getting-started/main.json
```

Deploy the template from the local main.json.

```powershell
$rgname = "bicep-demo"
New-AzResourceGroupDeployment -ResourceGroupName $rgname -TemplateFile ./main.json
```

```sh
$rgname='bicep-demo'
az deployment group create --resource-group MyFirstBicepResourceGroup --template-file ./main.json
```

**IMPORTANT**: At the time of writing the Azure CLI or the Az Powershell commands does not support deploying bicep files directly, but this is planned to be supported in the near future.

In the next video we will look at additional options of deploying to Azure.

## Additional links

- https://github.com/Azure/bicep/blob/main/docs/installing.md
