@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '2.4.0.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '7b750b98-bc2c-4059-80b9-f7228941a34f'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'MicrosoftCorporation'

# Copyright statement for this module
Copyright = '(c) 2016 Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'This module contains the standard DSC resources.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
DscResourcesToExport = @( 'Archive', 'Environment', 'Group', 'GroupSet', 'Registry', 'Script', 'Service', 'ServiceSet', 'User', 'WindowsFeature', 'WindowsFeatureSet', 'WindowsOptionalFeature', 'WindowsOptionalFeatureSet', 'WindowsPackageCab', 'WindowsProcess', 'ProcessSet' )

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'DesiredStateConfiguration', 'DSC', 'DSCResourceKit', 'DSCResource'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/PowerShell/PSDscResources/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/PowerShell/PSDscResources'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '* Cleaned User
* Updated User to have non-dependent unit tests.
* Ported fixes from [xPSDesiredStateConfiguration](https://github.com/PowerShell/xPSDesiredStateConfiguration):
    * WindowsProcess: Minor updates to integration tests
    * Registry: Fixed support for forward slashes in registry key names
* Group:
    * Group members in the "NT Authority", "BuiltIn" and "NT Service" scopes should now be resolved without an error. If you were seeing the errors "Exception calling ".ctor" with "4" argument(s): "Server names cannot contain a space character."" or "Exception calling ".ctor" with "2" argument(s): "Server names cannot contain a space character."", this fix should resolve those errors. If you are still seeing one of the errors, there is probably another local scope we need to add. Please let us know.
    * The resource will no longer attempt to resolve group members if Members, MembersToInclude, and MembersToExclude are not specified.
* Added Environment

'

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}




