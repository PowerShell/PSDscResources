Configuration MSFT_ServiceResource_Remove_Config {
    param
    (
        $ServiceName
    )

    Import-DscResource -ModuleName PSDscResources

    node localhost {
        Service RemoveService {
            Name            = $ServiceName
            Ensure          = 'Absent'
        }
    }
}
