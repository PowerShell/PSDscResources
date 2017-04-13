param
(
    [Parameter(Mandatory = $true)]
    [String]
    $ConfigurationName
)

Configuration $ConfigurationName
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $ProductId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Path,

        [ValidateSet('Present', 'Absent')]
        [String]
        $Ensure = 'Present'
    )

    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        MsiPackage MsiPackage1
        {
            ProductId = $ProductId
            Path = $Path
            Ensure = $Ensure
        }
    }
}
