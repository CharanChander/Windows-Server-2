# opstellig
- Server 1:
  - AD
  - DHCP
  - DNS
  - CA
- Server 2:
  - MySQL
  - 2e DNS
  
# TODO
Op 1e server ns record voor forward en reverse lookup zone, dan werkt zone transfer

# Stappenplan

## Stap 1
- ### Nerworkconfig
- ### AD
- ## Reboot
- ## DNS Serv1
- ## Server 2
- ## DHCP Serv1
- 

## Stap 2
- ### ssh "ws2-2425-charan.hogent\Administrator"@192.168.24.
- ### powershell start-process powershell -verb runas
- ### reboot winserver: shutdown -r -t 0

Set-NetFirewallProfile -Profile Private,Public,Domain -Enabled False
New-NetFirewallRule -DisplayName "Allow SQL Server Inbound TCP 1433" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action Allow
New-NetFirewallRule -DisplayName "Allow SQL Server Outbound TCP 1433" -Direction Outbound -Protocol TCP -LocalPort 1433 -Action Allow
