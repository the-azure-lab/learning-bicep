# Getting started with bicep

## Step 1: Install the bicep CLI
The first thing you need to get started with bicep is to download the bicep CLI from github (https://github.com/Azure/bicep).  You can do this to your local machine or to a container.

### Install bicep in a container (work from a container)

If you do not want to install stuff directly on your host you can do all of the excercises below in a container (it only requires that you have Docker Desktop installed, or some other method of running the container). This is my preferred method as it makes it easier to clean up installed software (and your machine does not become bloated with software).

```
# start the container
docker run -it --rm -v ${HOME}:/root/ -v ${PWD}:/work -w /work --net host ubuntu:18.04 bash
```

Inside the container you run the following comands to install bicep.
```
# Install curl & required libraries
apt-get update && apt-get install -y curl libcurl4 libicu60 libunwind8 libssl1.0

# Install the Azure CLI
apt-get update && curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install bicep
curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
chmod +x ./bicep
mv ./bicep /usr/local/bin/bicep

# Check versions
bicep --version
```

### Install bicep locally

If you prefer to have bicep installed locally run the commands below based on your operating system.

On Windows:
```
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
# Done!
```

On Linux:
```
# Install bicep
sudo curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
sudo chmod +x ./bicep \
sudo mv ./bicep /usr/local/bin/bicep
```

## Step 2: Get the bicep VSCode plugin

The second thing you need to do to get started is to get the bicep VSCode plugin. This will give you the intellisense and the formatting you need to get started.

- Go to extensions in VScode and search for bicep.
- Install the latest release of the Bicep extension.


## Step 3: Test that it is working

Creat a file called main.bicep and add the content below. 

```
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
```
bicep build main.bicep
```
The main.bicep file should compile without errors and you should now see a main.json file in your folder.

```
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

```
az group deployment create -g MyFirstBicepResourceGroup --template-uri https://github.com/the-azure-lab/learning-bicep/getting-started/main.json

```


In the next modules we will look at how additional options of deploying to Azure.
