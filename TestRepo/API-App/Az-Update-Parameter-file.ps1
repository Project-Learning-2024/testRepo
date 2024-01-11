#-----------------------------------------------------------------------
# <copyright file="Update-ARMParameters.ps1" company="Centrica and Microsoft Corporation">
# Copyright (c) Centrica and Microsoft Corporation. All rights reserved.
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, 
# INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
# </copyright>
#-----------------------------------------------------------------------

Param(

	[Parameter(Position=1, Mandatory = $True, HelpMessage='Specify a name for the api e.g. azsu-rostering-d-001.')]
    [String]$apiName,
	[Parameter(Position=2, Mandatory = $True, HelpMessage='Specify a name for apiHostingPlanName. azsu-rostering-d-001.')]
    [String]$apiHostingPlanName,
	[Parameter(Position=3, Mandatory = $True, HelpMessage='Specify a name for the resource group e.g. azsu-rg-rostering-d-001.')]
    [String]$apiLocation,
	[Parameter(Position=4, Mandatory = $True, HelpMessage='Specify a apiLocation. UK South.')]
    [String]$apiServerFarmResourceGroup,
	[Parameter(Position=5, Mandatory = $True, HelpMessage='Specify a name for the apiServerFarmresource group e.g. azsu-rg-rostering-d-001.')]
    [String]$apiSubscriptionId,                    
	[Parameter(Position=6, Mandatory = $True, HelpMessage='subid for law')]	
    [String]$diag_law_subid,
	[Parameter(Position=7, Mandatory = $True, HelpMessage='rg for law')]	
    [String]$diag_law_rg,
	[Parameter(Position=8, Mandatory = $True, HelpMessage='name for law')]	
    [String]$diagLoglaw_name	
	

)

# Get the time that script execution starts
$startTime = Get-Date

$parametersFilePath = "$PSScriptRoot\..\API-App\Azsu-API-App-Parameter.json"
$parametersFilePathExists = [System.IO.File]::Exists($parametersFilePath)
$parametersFilePathExists
if ($parametersFilePathExists)
{
	$tokenFilePath = $parametersFilePath
}else{
	$tokenFilePath = "$PSScriptRoot\..\API-App\Azsu-API-App-Parameter.json"
}
$tokenFilePath

(Get-Content -path $tokenFilePath -Raw) `
	-replace "_REGION_", $AzureRegion `
	-replace "_apiname_", $apiName `
	-replace "_apiHostingPlanName_", $apiHostingPlanName `
	-replace "_apiLocation_", $apiLocation `
	-replace "_apiServerFarmResourceGroup_", $apiServerFarmResourceGroup `
	-replace "_apiSubscriptionId_", $apiSubscriptionId `
    -replace "_diagLoglawsubid_", $diag_law_subid `
    -replace "_diagLoglawrg_", $diag_law_rg `
	-replace "_diagLoglawname_", $diagLoglaw_name `
	| Set-Content $tokenFilePath -ErrorVariable $notPresent

Write-Host "Viewing Update param file"
Get-Content -path $tokenFilePath

if (!$notPresent)
{
    Write-Output "Token file update complete."
	$UpdatedFile = Get-Content -path $tokenFilePath -Raw
	Write-Output $UpdatedFile
} else {
    Write-Output "Error"
}

# Mark the finish time of the script execution
$finishTime = Get-Date
# Output the time consumed in seconds
$TotalTime = ($finishTime - $startTime).TotalSeconds
Write-Verbose "Total time used (seconds): $TotalTime"