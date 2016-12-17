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
        $WindowsFeatureNames,

        [ValidateSet('Present', 'Absent')]
        [String]
        $Ensure = 'Present',

        [ValidateNotNullOrEmpty()]
        [String]
        $LogPath
    )

    Import-DscResource -ModuleName 'PSDscResources'

    WindowsFeatureSet WindowsFeatureSet1
    {
        Name = $WindowsFeatureNames
        Ensure = $Ensure
        LogPath = $LogPath
        IncludeAllSubfeature = $false
    }
}
