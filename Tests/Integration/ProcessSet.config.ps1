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
        [String[]]
        $ProcessPaths,

        [ValidateSet('Present', 'Absent')]
        [String]
        $Ensure = 'Present'
    )

    Import-DscResource -ModuleName 'PSDscResources'

    ProcessSet ProcessSet1
    {
        Path = $ProcessPaths
        Ensure = $Ensure
    }
}
