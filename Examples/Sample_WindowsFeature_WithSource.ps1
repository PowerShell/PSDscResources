<#
    .SYNOPSIS
        Installs the .NET 3.5 Framework feature, which needs additional files from the installation medium
        which are specified by the Source-Parameter.
#>
Configuration WindowsFeatureExample_Install_WithSource
{
    [CmdletBinding()]
    param ()

    Import-DscResource -ModuleName 'PSDscResources'

    WindowsFeatureSet WindowsFeatureSet1
    {
        Name                 = 'NET-Framework-Core'
        Ensure               = 'Present'
        IncludeAllSubFeature = $false
        Source               = 'E:\sources\sxs'
    }
}

