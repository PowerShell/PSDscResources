﻿$errorActionPreference = 'Stop'
Set-StrictMode -Version 'Latest'

# Import ResourceSetHelper for New-ResourceSetConfigurationScriptBlock
$script:dscResourcesFolderFilePath = Split-Path -Path $PSScriptRoot -Parent
$script:resourceSetHelperFilePath = Join-Path -Path $script:dscResourcesFolderFilePath -ChildPath 'ResourceSetHelper.psm1'
Import-Module -Name $script:resourceSetHelperFilePath

<#
    .SYNOPSIS
        A composite DSC resource to configure a set of similar WindowsFeature resources.

    .DESCRIPTION
        A composite DSC resource to configure a set of similar WindowsFeature resources.

    .PARAMETER Name
        The name of the roles or features to install or uninstall.

    .PARAMETER Ensure
        Specifies whether the roles or features should be installed or uninstalled.

        To install the features, set this property to Present.
        To uninstall the features, set this property to Absent.

    .PARAMETER IncludeAllSubFeature
        Specifies whether or not all subfeatures should be installed or uninstalled alongside the specified roles or features.

        If this property is true and Ensure is set to Present, all subfeatures will be installed.
        If this property is false and Ensure is set to Present, subfeatures will not be installed or uninstalled.
        If Ensure is set to Absent, all subfeatures will be uninstalled.

    .PARAMETER Credential
        The credential of the user account under which to install or uninstall the roles or features.

    .PARAMETER LogPath
        The custom file path to which to log this operation.
        If not passed in, the default log path will be used (%windir%\logs\ServerManager.log).
#>
Configuration WindowsFeatureSet
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true, HelpMessage="The name of the roles or features to install or uninstall.")]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $Name,

        [Parameter(HelpMessage="Specifies whether the roles or features should be installed or uninstalled.

        To install the features, set this property to Present.
        To uninstall the features, set this property to Absent.")]
        [ValidateSet('Present', 'Absent')]
        [String]
        $Ensure,

        [Parameter(HelpMessage="Specify the source")]
        [ValidateNotNullOrEmpty()]
        [String]
        $Source,

        [Parameter(HelpMessage="Specifies whether or not all subfeatures should be installed or uninstalled alongside the specified roles or features.

        If this property is true and Ensure is set to Present, all subfeatures will be installed.
        If this property is false and Ensure is set to Present, subfeatures will not be installed or uninstalled.
        If Ensure is set to Absent, all subfeatures will be uninstalled.")]
        [Boolean]
        $IncludeAllSubFeature,

        [Parameter(HelpMessage="The credential of the user account under which to install or uninstall the roles or features.")]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter(HelpMessage="The custom file path to which to log this operation. 
        If not passed in, the default log path will be used (%windir%\logs\ServerManager.log).")]
        [ValidateNotNullOrEmpty()]
        [String]
        $LogPath
    )

    $newResourceSetConfigurationParams = @{
        ResourceName = 'WindowsFeature'
        ModuleName = 'PSDscResources'
        KeyParameterName = 'Name'
        Parameters = $PSBoundParameters
    }
    
    $configurationScriptBlock = New-ResourceSetConfigurationScriptBlock @newResourceSetConfigurationParams

    # This script block must be run directly in this configuration in order to resolve variables
    . $configurationScriptBlock
}
