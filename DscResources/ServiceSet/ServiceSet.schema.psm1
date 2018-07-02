﻿$errorActionPreference = 'Stop'
Set-StrictMode -Version 'Latest'

# Import ResourceSetHelper for New-ResourceSetConfigurationScriptBlock
$script:dscResourcesFolderFilePath = Split-Path -Path $PSScriptRoot -Parent
$script:resourceSetHelperFilePath = Join-Path -Path $script:dscResourcesFolderFilePath -ChildPath 'ResourceSetHelper.psm1'
Import-Module -Name $script:resourceSetHelperFilePath

<#
    .SYNOPSIS
        A composite DSC resource to configure a set of similar Service resources.

    .DESCRIPTION
        A composite DSC resource to configure a set of similar Service resources.

    .PARAMETER Name
        An array of the names of the services to configure.

    .PARAMETER Ensure
        Specifies whether or not the set of services should exist.
        
        Set this property to Present to modify a set of services.
        Set this property to Absent to remove a set of services.

    .PARAMETER StartupType
        The startup type each service in the set should have.

    .PARAMETER BuiltInAccount
        The built-in account each service in the set should start under.

        Cannot be specified at the same time as Credential.

        The user account specified by this property must have access to the service
        executable paths in order to start the services.

    .PARAMETER State
        The state each service in the set should be in.
        From the default value defined in Service, the default will be Running.

    .PARAMETER Credential
        The credential of the user account each service in the set should start under.

        Cannot be specified at the same time as BuiltInAccount.

        The user specified by this credential will automatically be granted the Log on as a Service
        right. The user account specified by this property must have access to the service
        executable paths in order to start the services.
#>
Configuration ServiceSet
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true, HelpMessage="An array of the names of the services to configure.")]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $Name,

        [Parameter(HelpMessage="Specifies whether or not the set of services should exist. Set this property to Present to modify a set of services. Set this property to Absent to remove a set of services.")]
        [ValidateSet('Present', 'Absent')]
        [String]
        $Ensure,

        [Parameter(HelpMessage="The startup type each service in the set should have.")]
        [ValidateSet('Automatic', 'Manual', 'Disabled')]
        [String]
        $StartupType,

        [Parameter(HelpMessage="The built-in account each service in the set should start under. Cannot be specified at the same time as Credential. The user account specified by this property must have access to the service executable paths in order to start the services.")]
        [ValidateSet('LocalSystem', 'LocalService', 'NetworkService')]
        [String]
        $BuiltInAccount,

        [Parameter(HelpMessage="The state each service in the set should be in. From the default value defined in Service, the default will be Running.")]
        [ValidateSet('Running', 'Stopped', 'Ignore')]
        [String]
        $State,

        [Parameter(HelpMessage="he credential of the user account each service in the set should start under. Cannot be specified at the same time as BuiltInAccount. The user specified by this credential will automatically be granted the Log on as a Service right. The user account specified by this property must have access to the service executable paths in order to start the services.")]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential
    )

    $newResourceSetConfigurationParams = @{
        ResourceName = 'Service'
        ModuleName = 'PSDscResources'
        KeyParameterName = 'Name'
        Parameters = $PSBoundParameters
    }
    
    $configurationScriptBlock = New-ResourceSetConfigurationScriptBlock @newResourceSetConfigurationParams

    # This script block must be run directly in this configuration in order to resolve variables
    . $configurationScriptBlock
}
