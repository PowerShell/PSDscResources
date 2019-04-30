<#
    .SYNOPSIS
        Ensures that the DHCP Client and Windows Firewall services are running.
#>
Configuration Sample_ServiceSet_StartServices
{
    Import-DscResource -ModuleName 'PSDscResources'

    ServiceSet ServiceSet1
    {
        Name   = @( 'Dhcp', 'MpsSvc' )
        Ensure = 'Present'
        State  = 'Running'
    }
}
