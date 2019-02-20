@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
moduleVersion = '2.10.0.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '7b750b98-bc2c-4059-80b9-f7228941a34f'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = '(c) 2016 Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'This module contains the standard DSC resources.
Because PSDscResources overwrites in-box resources, it is only available for WMF 5.1. Many of the resource updates provided here are also included in the xPSDesiredStateConfiguration module which is still compatible with WMF 4 and WMF 5 (though that module is not supported and may be removed in the future).
'

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
DscResourcesToExport = @( 'Archive', 'Environment', 'Group', 'GroupSet', 'MsiPackage', 'Registry', 'Script', 'Service', 'ServiceSet', 'User', 'WindowsFeature', 'WindowsFeatureSet', 'WindowsOptionalFeature', 'WindowsOptionalFeatureSet', 'WindowsPackageCab', 'WindowsProcess', 'ProcessSet' )

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'DesiredStateConfiguration', 'DSC', 'DSCResourceKit', 'DSCResource', 'AzureAutomationNotSupported'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/PowerShell/PSDscResources/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/PowerShell/PSDscResources'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '* Fixed CompanyName typo - Fixes [Issue 100](https://github.com/PowerShell/PSDscResources/issues/100)
* Update LICENSE file to match the Microsoft Open Source Team
  standard - Fixes [Issue 120](https://github.com/PowerShell/PSDscResources/issues/120).
* Update `CommonResourceHelper` unit tests to meet Pester 4.0.0
  standards ([issue 129](https://github.com/PowerShell/PSDscResources/issues/129)).
* Update `ResourceHelper` unit tests to meet Pester 4.0.0
  standards ([issue 129](https://github.com/PowerShell/PSDscResources/issues/129)).
* Ported fixes from [xPSDesiredStateConfiguration](https://github.com/PowerShell/xPSDesiredStateConfiguration):
  * xArchive
    * Fix end-to-end tests.
    * Update integration tests to meet Pester 4.0.0 standards.
    * Update end-to-end tests to meet Pester 4.0.0 standards.
    * Update unit and integration tests to meet Pester 4.0.0 standards.
    * Wrapped all path and identifier strings in verbose messages with
      quotes to make it easier to identify the limit of the string when
      debugging.
    * Refactored date/time checksum code to improve testability and ensure
      tests can run on machines with localized datetime formats that are not
      US.
    * Fix "Get-ArchiveEntryLastWriteTime" to return `[datetime]`.
    * Improved verbose logging to make debugging path issues easier.
* Added .gitattributes file to ensure CRLF settings are configured correctly
  for the repository.
* Updated ".vscode\settings.json" to refer to AnalyzerSettings.psd1 so that
  custom syntax problems are highlighted in Visual Studio Code.
* Fixed style guideline violations in `CommonResourceHelper.psm1`.
* Updated "appveyor.yml" to meet more recent standards.
* Removed OS image version from "appveyor.yml" to use default image
  ([Issue 127](https://github.com/PowerShell/PSDscResources/issues/127)).
* Removed code to install WMF5.1 from "appveyor.yml" because it is already
  installed in AppVeyor images ([Issue 128](https://github.com/PowerShell/PSDscResources/issues/128)).
* Removed .vscode from .gitignore so that Visual Studio code environment
  settings can be committed.
* Environment
  * Update tests to meet Pester 4.0.0 standards ([issue 129](https://github.com/PowerShell/PSDscResources/issues/129)).
* Group
  * Update tests to meet Pester 4.0.0 standards ([issue 129](https://github.com/PowerShell/PSDscResources/issues/129)).
  * Fix unit tests to run on Nano Server.
  * Refactored unit tests to enclude Context fixtures and change functions
    to Describe fixtures.
* GroupSet
  * Update tests to meet Pester 4.0.0 standards ([issue 129](https://github.com/PowerShell/PSDscResources/issues/129)).

'

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}










