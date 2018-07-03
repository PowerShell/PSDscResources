$errorActionPreference = 'Stop'
Set-StrictMode -Version 'Latest'

# Import ResourceSetHelper for New-ResourceSetConfigurationScriptBlock
$script:dscResourcesFolderFilePath = Split-Path -Path $PSScriptRoot -Parent
$script:resourceSetHelperFilePath = Join-Path -Path $script:dscResourcesFolderFilePath -ChildPath 'ResourceSetHelper.psm1'
Import-Module -Name $script:resourceSetHelperFilePath

<#
    .SYNOPSIS
        A composite DSC resource to configure a set of similar Group resources.

    .DESCRIPTION
    Provides a mechanism to manage local groups on the target node. Use this resource when you want to add and/or remove the same list of members to more than one group, remove more than one group, or add more than one group with the same list of members.


    .PARAMETER GroupName
        An array of the names of the groups to configure.

    .PARAMETER Ensure
        Specifies whether or not the set of groups should exist.
        
        Set this property to Present to create or modify a set of groups.
        Set this property to Absent to remove a set of groups.

    .PARAMETER MembersToInclude
        The members that should be included in each group in the set.

    .PARAMETER MembersToExclude
        The members that should be excluded from each group in the set.

    .PARAMETER Credential
        The credential to resolve all groups and user accounts.
#>
Configuration GroupSet
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true, HelpMessage="The names of the groups for which you want to ensure a specific state.")]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $GroupName,

        [Parameter( HelpMessage="Indicates whether the groups exist. Set this property to Absent to ensure that the groups do not exist. Setting it to Present (the default value) ensures that the groups exist.")]
        [ValidateSet('Present', 'Absent')]
        [String]
        $Ensure,

        [Parameter( HelpMessage="Use this property to add members to the existing membership of the group. The value of this property is an array of strings of the form Domain\UserName. If you set this property in a configuration, do not use the Members property. Doing so will generate an error.")]
        [String[]]
        $MembersToInclude,

        [Parameter( HelpMessage="Use this property to remove members from the existing membership of the groups. The value of this property is an array of strings of the form Domain\UserName. If you set this property in a configuration, do not use the Members property. Doing so will generate an error.")]
        [String[]]
        $MembersToExclude,

        [Parameter( HelpMessage="The credentials required to access remote resources. Note: This account must have the appropriate Active Directory permissions to add all non-local accounts to the group; otherwise, an error will occur.")]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential
    )

    $newResourceSetConfigurationParams = @{
        ResourceName = 'Group'
        ModuleName = 'PSDscResources'
        KeyParameterName = 'GroupName'
        Parameters = $PSBoundParameters
    }

    $configurationScriptBlock = New-ResourceSetConfigurationScriptBlock @newResourceSetConfigurationParams

    # This script block must be run directly in this configuration in order to resolve variables
    . $configurationScriptBlock
}
