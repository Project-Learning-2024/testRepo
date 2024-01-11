# Param(
#     [string] $token = $token,
#     [string] $windowsLogonPassword = $windowsLogonPassword
# )

# cd "c:\adoagent"
# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Invoke-WebRequest -Uri "https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-win-x64-3.230.0.zip" -OutFile adoagent.zip
# Expand-Archive -Force adoagent.zip -DestinationPath .
# Remove-Item -Force adoagent.zip
# .\config.cmd --unattended --replace --acceptTeeEula --work work --url "https://dev.azure.com/FieldPlatform" --pool "nfrtestpoc" --auth pat --token "$(token)" --runAsService --runAsAutoLogon --windowsLogonAccount 'nfrpoc' --windowsLogonPassword '$(windowsLogonPassword)'

# New-Item "c:\software" -itemType Directory
# cd "c:\software"
# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Invoke-WebRequest -Uri "https://dl.pstmn.io/download/latest/win64" -OutFile postman.exe
# Start-Process -FilePath ".\postman.exe" -ArgumentList "-s"
# dir
cd "c:\software"
$msiFilePath = "azure-cli.msi"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest https://aka.ms/installazurecliwindowsx64 -OutFile $msiFilePath
             
$MSIArguments = @(
    "/i"
    ('"{0}"' -f $msiFilePath)
    "/qn"
    "/norestart"
)               
Start-Process "msiexec.exe" -ArgumentList $MSIArguments -Wait -NoNewWindow
Remove-Item -Path $msiFilePath  -Force