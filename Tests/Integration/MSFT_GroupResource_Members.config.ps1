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
        $GroupName,

        [ValidateSet('Present', 'Absent')]
        [ValidateNotNullOrEmpty()]
        [String]
        $Ensure = 'Present',

        [String[]]
        $Members = @()
    )

    Import-DscResource -ModuleName 'PSDscResources'

    Group Group1
    {
        GroupName = $GroupName
        Ensure = $Ensure
        Members = $Members
    }
}
