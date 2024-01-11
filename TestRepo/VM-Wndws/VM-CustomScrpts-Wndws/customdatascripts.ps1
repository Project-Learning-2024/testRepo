# Install Latest Powershell
iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"

# Install Googlechrome
wget -uri http://dl.google.com/chrome/install/375.126/chrome_installer.exe -OutFile "C:\temp\chrome.exe"
& 'C:\temp\chrome.exe'

# Install the Postman tool
Invoke-WebRequest -Uri "https://dl.pstmn.io/download/latest/win64" -OutFile "C:\temp\postman.exe"
Start-Process -FilePath 'C:\temp\postman.exe' -ArgumentList "/q /norestart" -Wait -NoNewWindow

# Install the OpenSSH Server
(New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start the sshd service
Start-Service sshd

# Setting service to auto startup
Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

# Install the dotnetframework
Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=2203306" -OutFile "C:\temp\dotnetframework4.8.1.exe"
Start-Process -FilePath 'C:\temp\dotnetframework4.8.1.exe' -ArgumentList "/q /norestart" -Wait -NoNewWindow

# Restarting the System
Restart-Computer -Force