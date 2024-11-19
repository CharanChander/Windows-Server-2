# powershell.exe C:\vagrant\3-WinServ2-1.ps1

# Set IP address without gateway
New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress 192.168.24.11 -PrefixLength 24 | Out-Null
Write-Host "IP address set"

# Set DNS server IP to 192.168.24.10 for Ethernet 2 and Ethernet 1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.24.10" | Out-Null
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddresses "192.168.24.10" | Out-Null
Write-Host "DNS client server address set"

Copy-Item -Path "C:\Vagrant\" -Destination "C:\Users\Vagrant\Documents" -Recurse
Write-Host "Shared folder copied"

# Install DNS features
Add-WindowsFeature -Name DNS -IncludeManagementTools | Out-Null
Add-WindowsFeature RSAT-DNS-Server | Out-Null
Write-Host "DNS features installed"

# Define the username and password
$username = "WS2-2425-charan\Administrator"
$password = "vagrant"

# Convert the password into a secure string
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# Create the credential object
$credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)
Write-Host "Credential object created"

# Add the computer to the domain
Add-Computer -DomainName "WS2-2425-charan.hogent" -Credential $credential -Restart
# REBOOT
