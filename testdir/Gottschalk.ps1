#Frage Klassennamen bei Programmstart ab:
$klassenname = Read-Host "Klassenname: "

#Server-Login-Daten:
$server = "172.16.7.140"
$secpasswd = ConvertTo-SecureString "!password123" -AsPlainText -Force 
$mycreds = New-Object System.Management.Automation.PSCredential ("heide\administrator", $secpasswd);


for ($i = 0; $i -lt 3; $i++) {
    $name = $klassenname+ "-" + $i.ToString()
    New-ADUser `
        -Server $server `
        -Credential $mycreds `
        -Name $name `
        -GivenName $i `
        -Surname "" `
        -SamAccountName $name `
        -Title "" `
        -State "" `
        -City "" `
        -Description "Test Account Creation" `
        -Enabled $True `
        -AccountPassword (ConvertTo-secureString !password123 -AsPlainText -Force) -ChangePasswordAtLogon $True 

    $fullPath = "172.16.7.140\heide\Users\{0}" -f $name
    $driveLetter = "T:"

    $User = Get-ADUser -Identity $name


    Set-ADUser $User -HomeDrive $driveLetter -HomeDirectory $fullPath -ea Stop
    $homeShare = New-Item -path $fullPath -ItemType Directory -force -ea Stop
    
    $acl = Get-Acl $homeShare
    
    $FileSystemRights = [System.Security.AccessControl.FileSystemRights]"Modify"
    $AccessControlType = [System.Security.AccessControl.AccessControlType]::Allow
    $InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit"
    $PropagationFlags = [System.Security.AccessControl.PropagationFlags]"InheritOnly"
    
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule ($User.SID, $FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)
    $acl.AddAccessRule($AccessRule)
    
    Set-Acl -Path $homeShare -AclObject $acl -ea Stop
    
    Write-Host ("HomeDirectory created at {0}" -f $fullPath)
   
}