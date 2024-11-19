# powershell.exe -File C:\vagrant\6-WinClient.ps1

# Define the username and password
$username = "WS2-2425-charan\Administrator"
$password = "vagrant"

# Copy the shared folder
Copy-Item -Path "C:\Vagrant\" -Destination "C:\Users\Vagrant\Documents" -Recurse | Out-Null
Write-Host "Shared folder copied"

# Convert the password into a secure string
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
Write-Host "Password converted to secure string"

# Create the credential object
$credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)
Write-Host "Credential object created"

Add-Computer -DomainName "WS2-2425-charan.hogent" -Credential $credential -Restart

#login = "WS2-2425-charan.hogent\Administrator"
#password = "vagrant"