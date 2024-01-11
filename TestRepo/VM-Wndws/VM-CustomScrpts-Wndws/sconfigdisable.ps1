#Disable Server Configuration Autolaunch 
Set-SConfig -AutoLaunch $false

# Restarting the System
Restart-Computer -Force
