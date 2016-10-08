Configuration Sample_Service_DeleteService
{

    param
    (
        [System.String[]] 
        $nodeName = 'localhost',

        [System.String]
        $Name,
        
        [System.String]
        [ValidateSet('Automatic', 'Manual', 'Disabled')]
        $StartupType,

        [System.String]
        [ValidateSet('LocalSystem', 'LocalService', 'NetworkService')]
        $BuiltInAccount,

        [System.Management.Automation.PSCredential]
        $Credential ,

        [System.String]
        [ValidateSet('Running', 'Stopped')]
        $State='Running',

        [System.String]
        [ValidateSet('Present', 'Absent')]
        $Ensure='Present',

        [System.String]
        $Path,

        [System.String]
        $DisplayName,

        [System.String]
        $Description,

        [System.String[]]
        $Dependencies
    )

    Import-DscResource -Name MSFT_ServiceResource -ModuleName PSDscResources

    Node $nodeName
    {
        Service service
        {
            Name = $Name
            Ensure = $Ensure
        }
    }
}


Sample_Service_DeleteService -Name 'Sample Service' -Ensure 'Absent' 


