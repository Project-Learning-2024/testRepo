#-----------------------------------------------------------------------
# <copyright file="Deploy-RosteringInfrastructure.ps1" company="Centrica and Microsoft Corporation">
# Copyright (c) Centrica and Microsoft Corporation. All rights reserved.
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, 
# INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
# </copyright>
#-----------------------------------------------------------------------

Param(
    [Parameter(Position=0, Mandatory = $True, HelpMessage='Specify a name for the resource group e.g. azsu-rg-rostering-d-001.')]
    [ValidateLength(1, 50)]
    [String]$ResourceGroupName,
    [Parameter(Position=1, Mandatory = $True, HelpMessage='Specify the name for the Azure region e.g. uksouth.')]
    [ValidateLength(1, 25)]
    [String]$AzureRegion
)


# Begin Script
# Set the output level to verbose and make the script stop on error
$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

# Get the time that script execution starts
$startTime = Get-Date


#Check if resrouce group already exsists, if not create it.
Get-AzResourceGroup -Name $ResourceGroupName -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent)
{
    New-AzResourceGroup -Name $ResourceGroupName -Location $AzureRegion
}

$parametersFilePath = "$PSScriptRoot\..\API-App\Azsu-API-App-Parameter.json"
$parametersFilePathExists = [System.IO.File]::Exists($parametersFilePath)
Write-Host "Reading content of param file"
Get-Content -path $parametersFilePath -Raw
if ($parametersFilePathExists)
{
    #Deploy environment using parent template & specific env type parameters file
    New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile "$PSScriptRoot\..\API-App\Azsu-API-App-Template.json" -TemplateParameterFile $parametersFilePath -Name "APIappDeployment" -Debug
}else{
    #If specific env type paramter file does not exist, use the 'default'
    New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile "$PSScriptRoot\..\API-App\Azsu-API-App-Template.json" -TemplateParameterFile "$PSScriptRoot\..\API-App\Azsu-API-App-Parameter.json" -Name "APIappDeployment" -Debug
}
