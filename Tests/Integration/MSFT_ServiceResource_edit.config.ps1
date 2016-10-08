Configuration MSFT_ServiceResource_Edit_Config {
    param
    (
        $ServiceName,
        $ServicePath,
        $ServiceDisplayName,
        $ServiceDescription,
        $ServiceDependsOn
    )

    Import-DscResource -ModuleName PSDscResources

    node localhost {
        Service EditService {
            Name            = $ServiceName
            Ensure          = 'Present'
            Path            = $ServicePath
            StartupType     = 'Manual'
            BuiltInAccount  = 'LocalService'
            DesktopInteract = $false
            State           = 'Stopped'
            DisplayName     = $ServiceDisplayName
            Description     = $ServiceDescription
            Dependencies    = $ServiceDependsOn
        }
    }
}
