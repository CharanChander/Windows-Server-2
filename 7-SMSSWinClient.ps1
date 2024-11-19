# powershell.exe -File C:\Users\vagrant\Documents\Vagrant\7-MMSQLWinClient.ps1

$URL = "https://aka.ms/ssmsfullsetup"
$media_path = "C:\Users\Administrator\Downloads\SSMS-Setup-ENU.exe"
$install_path = "$env:SystemDrive\SSMSto"
$params = "/Install /Quiet SSMSInstallRoot=`"$install_path`""

# RSAT DHCP
Add-WindowsCapability -Online -Name Rsat.Dhcp.Tools~~~~0.0.1.0 | Out-Null
Write-Host "RSAT DHCP installed"

# RSAT DNS
Add-WindowsCapability -Online -Name Rsat.Dns.Tools~~~~0.0.1.0 | Out-Null
Write-Host "RSAT DNS installed"

# RSAT AD
Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 | Out-Null
Write-Host "RSAT AD DS and LDS Tools installed"

# RSAT CA
Add-WindowsCapability -Online -Name Rsat.CertificateServices.Tools~~~~0.0.1.0 | Out-Null
Write-Host "RSAT Certificate Services Tools installed"

# SSMS downloaden
Invoke-WebRequest -Uri $URL -OutFile $media_path | Out-Null
Write-Host "SSMS downloaded"

Start-Process -FilePath $media_path -ArgumentList $params -Wait | Out-Null
Write-Host "SSMS installed"
