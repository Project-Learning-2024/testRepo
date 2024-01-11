Param(
    [string] $tokn = $tokn,
    [string] $vmuser = $vmuser,
    [string] $vmpass = $vmpass,
    [string] $url = $url,
    [string] $agentpoolname = $agentpoolname,
    [string] $softwarepath = $softwarepath
    
)
New-Item "c:\adoagents" -itemType Directory
cd "c:\adoagents"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-win-x64-3.230.0.zip" -OutFile adoagent.zip
Expand-Archive -Force adoagent.zip -DestinationPath .
Remove-Item -Force adoagent.zip
.\config.cmd --unattended --replace --acceptTeeEula --work work --url "$url" --pool "$agentpoolname" --auth pat --token "$tokn" --runAsService --runAsAutoLogon --windowsLogonAccount "$vmuser" --windowsLogonPassword "$vmpass"

New-Item "$softwarepath" -itemType Directory
cd "$softwarepath"
$azureclimsiFilePath = "azurecli.msi"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest https://aka.ms/installazurecliwindowsx64 -OutFile $azureclimsiFilePath
             
$MSIArguments = @(
    "/i"
    ('"{0}"' -f $azureclimsiFilePath)
    "/qn"
    "/norestart"
)               
Start-Process "msiexec.exe" -ArgumentList $MSIArguments -Wait -NoNewWindow
Remove-Item -Path $azureclimsiFilePath  -Force

cd "$softwarepath"
$psmsiFilePath = "ps.msi"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest https://github.com/Azure/azure-powershell/releases/download/v11.0.0-November2023/Az-Cmdlets-11.0.0.37926-x64.msi -OutFile $psmsiFilePath
             
$MSIArguments = @(
    "/i"
    ('"{0}"' -f $psmsiFilePath)
    "/qn"
    "/norestart"
)               
Start-Process "msiexec.exe" -ArgumentList $MSIArguments -Wait -NoNewWindow
Remove-Item -Path $psmsiFilePath  -Force

# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Install-PackageProvider -Name Nuget -MinimumVersion 2.8.5.201 -Force
# Install-Module AzureRM