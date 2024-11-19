# powershell.exe -File C:\vagrant\1-ADWinServ1.ps1

# Ip adres instellen zonder gateway
New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress 192.168.24.10 -PrefixLength 24 | Out-Null
Write-Host "IP adres ingesteld"

# Shared folder kopieren voor AD
Copy-Item -Path "C:\Vagrant\" -Destination "C:\Users\Vagrant\Documents" -Recurse | Out-Null
Write-Host "Gedeelde map gekopieerd"

# AD
Install-windowsfeature -name AD-Domain-Services,DNS -IncludeManagementTools | Out-Null
Write-Host "AD en DNS geïnstalleerd"

$SecurePassword = ConvertTo-SecureString "1243Vagrant@" -AsPlainText -Force | Out-Null
Write-Host "WW aangemaakt"

Install-ADDSForest -DomainName "WS2-2425-charan.hogent" -DomainMode "7" -ForestMode "7" -InstallDns:$true -Force:$true -SafeModeAdministratorPassword $SecurePassword | Out-Null

# HIER REBOOT HIJ