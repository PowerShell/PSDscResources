@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '2.2.0.0'

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
DscResourcesToExport = 'Group', 'GroupSet', 'Script', 'Service', 'ServiceSet', 'User', 'WindowsFeature', 'WindowsFeatureSet', 'WindowsOptionalFeature', 'WindowsOptionalFeatureSet', 'WindowsPackageCab', 'WindowsProcess', 'ProcessSet'

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
        ReleaseNotes = '* WindowsFeature:
    * Added Catch to ignore RuntimeException when importing ServerManager module. This solves the issue described [here](https://social.technet.microsoft.com/Forums/en-US/9fc314e1-27bf-4f03-ab78-5e0f7a662b8f/importmodule-servermanager-some-or-all-identity-references-could-not-be-translated?forum=winserverpowershell).
    * Updated unit tests.   
* Added WindowsProcess
* CommonTestHelper:
    * Added Get-AppVeyorAdministratorCredential.
    * Added Set-StrictMode -"Latest" and $errorActionPreference -"Stop".
* Service:
    * Updated resource module, unit tests, integration tests, and examples to reflect the changes made in xPSDesiredStateConfiguration.
* Group:
    * Updated resource module, examples, and integration tests to reflect the changes made in xPSDesiredStateConfiguration.
* Added Script.
* Added GroupSet, ServiceSet, WindowsFeatureSet, WindowsOptionalFeatureSet, and ProcessSet.
* Added Set-StrictMode -"Latest" and $errorActionPreference -"Stop" to Group, Service, User, WindowsFeature, WindowsOptionalFeature, WindowsPackageCab.
* Fixed bug in WindowsFeature in which is was checking the "Count" property of an object that was not always an array.
* Cleaned Group and Service resources and tests.
* Added Registry.

'

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}



