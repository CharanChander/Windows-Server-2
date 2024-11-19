# ssh "ws2-2425-charan.hogent\Administrator"@192.168.24.11
# powershell.exe -File C:\Users\vagrant\Documents\Vagrant\4-WinServ2-2.ps1

# Add the zone transfer policy
Add-DnsServerSecondaryZone -Name "WS2-2425-charan.hogent" -ZoneFile "WS2-2425-charan.hogent.dns" -MasterServers 192.168.24.10 | Out-Null
Write-Host "DNS secondary zone added"

# NS record toevoegen
dnscmd server1.WS2-2425-charan.hogent /RecordAdd WS2-2425-charan.hogent "@" NS server2.WS2-2425-charan.hogent | Out-Null
Write-Host "DNS NS record added"

# SQL
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
Write-Host "NuGet package provider installed"

Install-Module -Name SqlServerDsc -Force | Out-Null
Write-Host "SqlServerDsc module installed"

D:setup.exe /Q /ACTION=Install /IACCEPTSQLSERVERLICENSETERMS /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER /SQLSYSADMINACCOUNTS="ws2-2425-charan.hogent\Administrator" /SECURITYMODE=SQL /SAPWD="1243Vagrant@" /UpdateEnabled=False /TCPENABLED=1 /NPENABLED=1 | Out-Null
Write-Host "SQL Server installed"

New-NetFirewallRule -DisplayName "Allow SQL Server Inbound TCP 1433" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action Allow | Out-Null
New-NetFirewallRule -DisplayName "Allow SQL Server Outbound TCP 1433" -Direction Outbound -Protocol TCP -LocalPort 1433 -Action Allow | Out-Null
Write-Host "Firewall rules added"