Configuration MSFT_ServiceResource_Add_Config {
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
        Service AddService {
            Name            = $ServiceName
            Ensure          = 'Present'
            Path            = $ServicePath
            StartupType     = 'Automatic'
            BuiltInAccount  = 'LocalSystem'
            DesktopInteract = $true
            State           = 'Running'
            DisplayName     = $ServiceDisplayName
            Description     = $ServiceDescription
            Dependencies    = $ServiceDependsOn
        }
    }
}
