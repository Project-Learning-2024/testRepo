param(
    [String[]] $FA_names,
    [string] $RG
    )
$TemplateFile = "FA-HTTPS-FTP-Change_ARM_Template.json"
$TemplateFile = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, $TemplateFile))
Write-Host "Template File Path: $TemplateFile   
foreach ($FA_name in $FA_names)
{
    Write-Output $FA_name
    New-AzureRmResourceGroupDeployment -Name TestDeployment `
                                        -ResourceGroupName $RG `
                                        -TemplateFile $TemplateFile `
                                        -Mode Incremental `
                                        -Force -Verbose `
                                        -ErrorVariable ErrorMessages
    if ($ErrorMessages) {
    Write-Output '', 'Template deployment returned the following errors:', @(@($ErrorMessages) | ForEach-Object { $_.Exception.Message.TrimEnd("`r`n") })
    }
}
