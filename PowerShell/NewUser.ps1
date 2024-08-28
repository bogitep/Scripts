$FirstName = Read-Host -Prompt "First Name"
$LastName = Read-Host -Prompt "Last Name"
$Password = Read-Host -Prompt "Password" -AsSecureString

if (-not (Test-Path -Path "C:\Scripts")) {
    New-Item -Path "C:\Scripts" -ItemType Directory
}

$SamAccountName = "$FirstName.$LastName"
$UserPrincipalName = "$SamAccountName@domain.com"
$OU = "OU=Script,DC=WSA,DC=LAB"
try {
    New-ADUser -GivenName $FirstName -Surname $LastName -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName -Name "$FirstName $LastName" -Path $OU -AccountPassword $Password -Enabled $true
    Write-Host "User $FirstName $LastName ($SamAccountName) has been created successfully."
} catch {
    Write-Host "Failed to create user $FirstName $LastName ($SamAccountName)."
    Write-Host $_.Exception.Message
}

$folderPath = "C:\Scripts\$SamAccountName"
if (-not (Test-Path -Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory
    Write-Host "Created personal folder: $folderPath"
} else {
    Write-Host "Personal folder already exists: $folderPath"
}
$sharedFolderPath = "C:\Shared\$SamAccountName"
if (-not (Test-Path -Path $sharedFolderPath)) {
    New-Item -Path $sharedFolderPath -ItemType Directory
    Write-Host "Created shared folder: $sharedFolderPath"
} else {
    Write-Host "Shared folder already exists: $sharedFolderPath"
}
