Configuration Sample_User_CreateUser
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -ModuleName PSDscResources

    Node localhost
    {
        User UserExample
        {
            Ensure   = 'Present'  # To ensure the user account does not exist, set Ensure to "Absent"
            UserName = 'SomeUserName'
            Password = $Credential # This needs to be a credential object
        }
    }
}
