# DHCP
Install-WindowsFeature DHCP -IncludeManagementTools | Out-Null
Write-Host "DHCP installed"

# ALS ADMINISTRATOR Admininstrator@192.168.24.10
Add-DhcpServerInDC | Out-Null
Write-Host "DHCP server added"

netsh dhcp add securitygroups | Out-Null
Write-Host "DHCP security groups added"

# Creëer een DHCP-scope met het gewenste IP-bereik
Add-DhcpServerv4Scope -Name "scope1" -StartRange 192.168.24.101 -EndRange 192.168.24.200 -SubnetMask 255.255.255.0 -State Active | Out-Null
Write-Host "DHCP scope created"

## exclude last 50 addresses
Add-DhcpServerv4ExclusionRange -ScopeId 192.168.24.0 -StartRange 192.168.24.151 -EndRange 192.168.24.200 | Out-Null
Write-Host "DHCP exclusion range added"

# Stel de DNS-serveropties in voor de scope
Set-DhcpServerv4OptionValue -ScopeId 192.168.24.0 -OptionId 006 -Value 192.168.24.10, 192.168.24.11 | Out-Null
Write-Host "DHCP DNS server options set"

# Stel de domeinnaamoptie in voor DNS (optioneel maar aanbevolen)
Set-DhcpServerv4OptionValue -ScopeId 192.168.24.0 -OptionId 015 -Value "WS2-2425-charan.hogent" | Out-Null
Write-Host "DHCP domain name option set"

# Aan na reboot
Set-Service -Name dhcpserver -StartupType Automatic | Out-Null
Write-Host "DHCP service set to automatic"

# Volgend script starten
powershell.exe -File C:\Users\vagrant\Documents\Vagrant\8-CAWinServ1.ps1