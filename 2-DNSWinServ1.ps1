# ssh "ws2-2425-charan.hogent\Administrator"@192.168.24.10
# powershell.exe -File C:\Users\vagrant\Documents\Vagrant\2-DNSWinServ1.ps1

$charan = @{
    Name = 'charan'
    AccountPassword = '1243Vagrant@' | ConvertTo-SecureString -AsPlainText -Force
    Enabled = $true
}
New-ADUser @charan | Out-Null
Write-Host "AD user created"

# DNS
Install-WindowsFeature -Name DNS -IncludeManagementTools | Out-Null
Write-Host "DNS installed"

Set-DnsServerForwarder -IPAddress "1.1.1.2" | Out-Null
Write-Host "DNS forwarder set"

Add-DnsServerPrimaryZone -NetworkId "192.168.24.0/24" -ReplicationScope "Domain" | Out-Null
Add-DnsServerPrimaryZone -Name 'WS2-2425-charan.hogent' -ReplicationScope 'Forest' -PassThru | Out-Null
Write-Host "DNS primary zone added"

Remove-DnsServerResourceRecord -name "server1" -Zonename "WS2-2425-charan.hogent" -RRType A | Out-Null
Write-Host "NAT record verwijderd"

Add-DnsServerResourceRecordA -Name 'server1' -ZoneName 'WS2-2425-charan.hogent' -IPv4Address '192.168.24.10' | Out-Null
Add-DnsServerResourceRecordA -Name 'server2' -ZoneNameowershell.exe -File C:\Users\vagrant\Documents\Vagrant\2-DNSWinServ1.ps1
'WS2-2425-charan.hogent' -IPv4Address '192.168.24.11' | Out-Null
Write-Host "DNS A records added"

# Add PTR records to the reverse lookup zone
Add-DnsServerResourceRecordPtr -Name '10' -ZoneName '24.168.192.in-addr.arpa' -PtrDomainName 'server1.WS2-2425-charan.hogent' | Out-Null
Add-DnsServerResourceRecordPtr -Name '11' -ZoneName '24.168.192.in-addr.arpa' -PtrDomainName 'server2.WS2-2425-charan.hogent' | Out-Null
Write-Host "DNS PTR records added"

# Enable secure zone transfers
Set-DnsServerPrimaryZone -name "WS2-2425-charan.hogent" -SecureSecondaries "TransferToZoneNameServer" -PassThru | Out-Null
Write-Host "Secure zone transfers enabled"

# Add a client subnet and zone transfer policy
Add-DnsServerClientSubnet -Name 'AllowedSubnet' -IPv4Subnet 192.168.24.0/24 -PassThru | Out-Null
Add-DnsServerZoneTransferPolicy -Name 'AllowedZoneTransfers' -Action IGNORE -ClientSubnet 'AllowedSubnet' | Out-Null
Write-Host "Client subnet and zone transfer policy added"

# NSRecord toevoegen
dnscmd localhost /RecordAdd WS2-2425-charan.hogent "@" NS WinServ1.WS2-2425-charan.hogent | Out-Null
dnscmd localhost /RecordAdd WS2-2425-charan.hogent "@" NS WinServ2.WS2-2425-charan.hogent | Out-Null
Write-Host "DNS NS records added"

# Dns instellen
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.24.10" | Out-Null
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddresses "192.168.24.10" | Out-Null
Write-Host "DNS client server address set"

powershell.exe -File C:\Users\vagrant\Documents\Vagrant\5-DHCPWinServ1.ps1  