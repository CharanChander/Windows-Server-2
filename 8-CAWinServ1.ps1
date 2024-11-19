# Install the Active Directory Certificate Services (AD CS) roles
Install-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools | Out-Null
Write-Host "AD CS roles installed"

# Configure the Certification Authority as a standalone root CA
Install-AdcsCertificationAuthority -CAType EnterpriseRootCA -CryptoProviderName 'RSA#Microsoft Software Key Storage Provider' -HashAlgorithmName SHA256 -KeyLength 2048 -ValidityPeriod Years -ValidityPeriodUnits 5 -Force | Out-Null
Write-Host "CA configured"

# Create a new group policy
New-GPO -Name 'Trusted Root CA' -ErrorAction SilentlyContinue | Out-Null
Write-Host "Group policy created"

# Link the group policy to the domain
$DomainDN = (Get-ADDomain).DistinguishedName
New-GPLink -Name 'Trusted Root CA' -Target $DomainDN | Out-Null
Write-Host "Group policy linked"

Install-WindowsFeature ADCS-Web-Enrollment -IncludeManagementTools | Out-Null
Write-Host "AD CS web enrollment installed"

Install-WindowsFeature ADCS-Enroll-Web-Svc -IncludeManagementTools | Out-Null
Write-Host "AD CS enrollment web service installed"

Install-AdcsEnrollmentWebService -Force | Out-Null
Write-Host "AD CS enrollment web service installed"

Install-AdcsWebEnrollment -Force | Out-Null
Write-Host "AD CS web enrollment installed"