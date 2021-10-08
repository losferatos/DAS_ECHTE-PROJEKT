# Import active directory module for running AD cmdlets
Import-Module activedirectory

#Store the data from ADUsers.csv in the $ADUsers variable
$ADUsers = Import-csv C:\it\powershell_create_bulk_users\bulk_users1_quote.csv

foreach ($User in $ADUsers)
{
    $Username   = $User.username
    $Password   = $User.password
    $Firstname  = $User.firstname
    $Lastname   = $User.lastname
    $OU         = $User.ou #This field refers to the OU the user account is to be created in
    $Password = $User.Password

    if (Get-ADUser -Filter {SamAccountName -eq $Username})
    {
         Write-Warning "A user account with username $Username already exist in Active Directory."
    }
    else
    {
        New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username" `
            -Name "$Firstname $Lastname" `
            -Path $OU `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $True           
    }
}