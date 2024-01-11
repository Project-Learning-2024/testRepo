#Install ADO Agent

Param(
    [string] $tokn = $tokn,
    [string] $vmuser = $vmuser,
    [string] $vmpass = $vmpass,
    [string] $url = $url,
    [string] $agentpoolname = $agentpoolname
    
)

New-Item "c:\adoagents" -itemType Directory
cd "c:\adoagents"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-win-x64-3.230.0.zip" -OutFile adoagent.zip
Expand-Archive -Force adoagent.zip -DestinationPath .
Remove-Item -Force adoagent.zip
.\config.cmd --unattended --replace --acceptTeeEula --work work --url "$url" --pool "$agentpoolname" --auth pat --token "$tokn" --runAsService --runAsAutoLogon --windowsLogonAccount "$vmuser" --windowsLogonPassword "$vmpass"
