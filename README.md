master: [![Build status](https://ci.appveyor.com/api/projects/status/9uf3wyys7ky7776d/branch/dev?svg=true)](https://ci.appveyor.com/project/PowerShell/psdscresources/branch/master)
dev: [![Build status](https://ci.appveyor.com/api/projects/status/9uf3wyys7ky7776d/branch/master?svg=true)](https://ci.appveyor.com/project/PowerShell/psdscresources/branch/dev)

# PSDscResources
  
 
 EXPAND
 EXPAND
 COLLAPSED:  142 lines with no changes
#### Requirements
#### Requirements
  
 
 * Target machine must be running Windows Server 2008 or later.
* Target machine must be running Windows Server 2008 or later.
 * Target machine must have access to the DISM PowerShell module.
* Target machine must have access to the DISM PowerShell module.
 * Target machine must have access to the ServerManager module.
* Target machine must have access to the ServerManager module.
r1
 In progress line 150
NEW COMMENT
kwirkykatKatie Keim

# PSDscResources

PSDscResources is the new home of the in-box resources from PSDesiredStateConfiguration.

These resources are a combination of those in the in-box PSDesiredStateConfiguration module as well as community contributions from our experimental [xPSDesiredStateConfiguration](https://github.com/PowerShell/xPSDesiredStateConfiguration) module on GitHub.
These resources have also recently been updated to meet the DSC Resource Kit [High Quality Resource Module (HQRM) guidelines](https://github.com/PowerShell/DscResources/blob/master/HighQualityModuleGuidelines.md).

In-box resources not currently included in this module should not be affected and can still load from the in-box PSDesiredStateConfiguration module.

Because PSDscResources overwrites in-box resources, it is only available for WMF 5.1.
Many of the resource updates provided here are also included in the [xPSDesiredStateConfiguration](https://github.com/PowerShell/xPSDesiredStateConfiguration) module which is still compatible with WMF 4 and WMF 5 (though this module is not supported and may be removed in the future).

To update your in-box resources to the newest versions provided by PSDscResources, first install PSDscResources from the PowerShell Gallery:
```powershell
Install-Module PSDscResources
```

Then, simply add this line to your DSC configuration:
```powershell
Import-DscResource -ModuleName PSDscResources
```

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Contributing
Please check out the common DSC Resources [contributing guidelines](https://github.com/PowerShell/DscResource.Kit/blob/master/CONTRIBUTING.md).

## Resources
* [Group](#group): Provides a mechanism to manage local groups on the target node.
* [Service](#service): Provides a mechanism to configure and manage Windows services.
* [User](#user): Provides a mechanism to manage local users on the target node.
* [WindowsFeature](#windows-feature): Provides a mechanism to install or uninstall windows roles or features on a target node.
* [WindowsOptionalFeature](#windows-optional-feature): Provides a mechanism to enable or disable optional features on a target node.
* [WindowsPackageCab](#windows-package-cab): Provides a mechanism to install or uninstall a package from a windows cabinet (cab) file on a target node.

### Resources that work on Nano Server

* [Group](#group)
* [Service](#service)
* [User](#user)
* [WindowsOptionalFeature](#windows-optional-feature)
* [WindowsPackageCab](#windows-package-cab)

### Group
Provides a mechanism to manage local groups on the target node.
This resource works on Nano Server.

#### Requirements

None

#### Parameters
* **[String] GroupName** _(Key)_: The name of the group to create, modify, or remove.
* **[String] Ensure** _(Write)_: Indicates if the group should exist or not. To add a group or modify an existing group, set this property to Present. To remove a group, set this property to Absent. The default value is Present. { *Present* | Absent }.
* **[String] Description** _(Write)_: The description the group should have.
* **[String[]] Members** _(Write)_: The members the group should have. This property will replace all the current group members with the specified members. Members should be specified as strings in the format of their domain qualified name (domain\username), their UPN (username@domainname), their distinguished name (CN=username,DC=...), or their username (for local machine accounts). Using either the MembersToExclude or MembersToInclude properties in the same configuration as this property will generate an error.
* **[String[]] MembersToInclude** _(Write)_: The members the group should include. This property will only add members to a group. Members should be specified as strings in the format of their domain qualified name (domain\username), their UPN (username@domainname), their distinguished name (CN=username,DC=...), or their username (for local machine accounts). Using the Members property in the same configuration as this property will generate an error.
* **[String[]] MembersToExclude** _(Write)_: The members the group should exclude. This property will only remove members from a group. Members should be specified as strings in the format of their domain qualified name (domain\username), their UPN (username@domainname), their distinguished name (CN=username,DC=...), or their username (for local machine accounts). Using the Members property in the same configuration as this property will generate an error.
* **[System.Management.Automation.PSCredential] Credential** _(Write)_: A credential to resolve non-local group members.

#### Read-Only Properties from Get-TargetResource

None

#### Examples

* [Create or modify a group with Members](https://github.com/PowerShell/PSDscResources/blob/master/Examples/Sample_Group_Members.ps1)
* [Create or modify a group with MembersToInclude and/or MembersToExclude](https://github.com/PowerShell/PSDscResources/blob/master/Examples/Sample_Group_Members.ps1)

### Service
Provides a mechanism to configure and manage Windows services.
This resource works on Nano Server.

#### Requirements

None

#### Parameters

* **[String] Name** _(Key)_: Indicates the service name. Note that sometimes this is different from the display name. You can get a list of the services and their current state with the Get-Service cmdlet.
* **[String] Ensure** _(Write)_: Indicates whether the service is present or absent. Defaults to Present. { *Present* | Absent }.
* **[String] Path** _(Write)_: The path to the service executable file.
* **[String] StartupType** _(Write)_: Indicates the startup type for the service. { Automatic | Disabled | Manual }.
* **[String] BuiltInAccount** _(Write)_: Indicates the sign-in account to use for the service. { LocalService | LocalSystem | NetworkService }.
* **[PSCredential] Credential** _(Write)_: The credential to run the service under.
* **[Boolean] DesktopInteract** _(Write)_: Indicates whether the service can create or communicate with a window on the desktop. Must be false for services not running as LocalSystem. Defaults to False.
* **[String] State** _(Write)_: Indicates the state you want to ensure for the service. Defaults to Running. { *Running* | Stopped | Ignore }.
* **[String] DisplayName** _(Write)_: The display name of the service.
* **[String] Description** _(Write)_: The description of the service.
* **[String[]] Dependencies** _(Write)_: An array of strings indicating the names of the dependencies of the service.
* **[Uint32] StartupTimeout** _(Write)_: The time to wait for the service to start in milliseconds. Defaults to 30000.
* **[Uint32] TerminateTimeout** _(Write)_: The time to wait for the service to stop in milliseconds. Defaults to 30000.

#### Read-Only Properties from Get-TargetResource

None

#### Examples

* [Create a service](https://github.com/PowerShell/PSDscResources/blob/master/Examples/Sample_Service_CreateService.ps1)
* [Delete a service](https://github.com/PowerShell/PSDscResources/blob/master/Examples/Sample_Service_DeleteService.ps1)

### User
Provides a mechanism to manage local users on a target node.

#### Requirements

None

#### Parameters

* **[String] UserName** _(Key)_: Indicates the account name for which you want to ensure a specific state.
* **[String] Description** _(Write)_: Indicates the description you want to use for the user account.
* **[Boolean] Disabled** _(Write)_: Indicates if the account is enabled. Set this property to $true to ensure that this account is disabled, and set it to $false to ensure that it is enabled.
   - Suported values: $true, $false
   - Default value: $false
* **[String] Ensure** _(Write)_: Ensures that the feature is present or absent.
   - Supported values: Present, Absent
   - Default Value: Present
* **[String] FullName** _(Write)_: Represents a string with the full name you want to use for the user account.
* **[PSCredential] Password** _(Write)_: Indicates the password you want to use for this account.
* **[Boolean] PasswordChangeNotAllowed** _(Write)_: Indicates if the user can change the password. Set this property to $true to ensure that the user cannot change the password, and set it to $false to allow the user to change the password.
   - Suported values: $true, $false
   - Default value: $false
* **[Boolean] PasswordChangeRequired** _(Write)_: Indicates if the user must change the password at the next sign in. Set this property to $true if the user must change the password.
   - Suported values: $true, $false
   - Default value: $true
* **[Boolean] PasswordNeverExpires** _(Write)_: Indicates if the password will expire. To ensure that the password for this account will never expire, set this property to $true, and set it to $false if the password will expire.
   - Suported values: $true, $false
   - Default value: $false

#### Read-Only Properties from Get-TargetResource

None
   
#### Examples

* [Create a new User](https://github.com/PowerShell/PSDscResources/blob/master/Examples/Sample_User_CreateUser.ps1)

### WindowsFeature
Provides a mechanism to install or uninstall Windows roles or features on a target node.

#### Requirements

* Target machine must be running Windows Server 2008 or later.
* Target machine must have access to the DISM PowerShell module.
* Target machine must have access to the ServerManager module (provided by default on Windows Server).

#### Parameters

* **[String] Name** _(Key)_: Indicates the name of the role or feature that you want to ensure is added or removed. This is the same as the Name property from the Get-WindowsFeature cmdlet, and not the display name of the role or feature.
* **[PSCredential] Credential** _(Write)_: Indicates the credential to use to add or remove the role or feature if needed.
* **[String] Ensure** _(Write)_: Specifies whether the feature should be installed (Present) or uninstalled (Absent) { *Present* | Absent }.
* **[Boolean] IncludeAllSubFeature** _(Write)_: Specifies whether or not all subfeatures should be installed with the specified role or feature. The default value is false.
* **[String] LogPath** _(Write)_: Indicates the path to a log file to log the operation.

#### Read-Only Properties from Get-TargetResource

* **[String] DisplayName** _(Read)_: The display name of the retrieved role or feature.

#### Examples

* [Install or uninstall a Windows feature](https://github.com/PowerShell/PSDscResources/blob/master/Examples/Sample_xWindowsFeature.ps1)


### WindowsOptionalFeature
Provides a mechanism to enable or disable optional features on a target node.
This resource works on Nano Server.

#### Requirements

* Target machine must be running a Windows client operating system, Windows Server 2012 or later, or Nano Server.
* Target machine must have access to the DISM PowerShell module

#### Parameters

* **[String] Name** _(Key)_: The name of the Windows optional feature to enable or disable.
* **[String] Ensure** _(Write)_: Specifies whether the feature should be enabled or disabled. To enable the feature, set this property to Present. To disable the feature, set the property to Absent. The default value is Present. { *Present* | Absent }.
* **[Boolean] RemoveFilesOnDisable** _(Write)_: Specifies that all files associated with the feature should be removed if the feature is being disabled.
* **[Boolean] NoWindowsUpdateCheck** _(Write)_: Specifies whether or not DISM contacts Windows Update (WU) when searching for the source files to enable the feature. If $true, DISM will not contact WU.
* **[String] LogPath** _(Write)_: The path to the log file to log this operation. There is no default value, but if not set, the log will appear at %WINDIR%\Logs\Dism\dism.log.
* **[String] LogLevel** _(Write)_: The maximum output level to show in the log. ErrorsOnly will log only errors. ErrorsAndWarning will log only errors and warnings. ErrorsAndWarningAndInformation will log errors, warnings, and debug information). The default value is "ErrorsAndWarningAndInformation".  { ErrorsOnly | ErrorsAndWarning | *ErrorsAndWarningAndInformation* }.

#### Read-Only Properties from Get-TargetResource

* **[String[]] CustomProperties** _(Read)_: The custom properties retrieved from the Windows optional feature as an array of strings.
* **[String] Description** _(Read)_: The description retrieved from the Windows optional feature.
* **[String] DisplayName** _(Read)_: The display name retrieved from the Windows optional feature.

#### Examples

* [Enable the specified windows optional feature and output logs to the specified path](https://github.com/PowerShell/PSDscResources/blob/master/Examples/Sample_WindowsOptionalFeature.ps1)

### WindowsPackageCab
Provides a mechanism to install or uninstall a package from a windows cabinet (cab) file on a target node.
This resource works on Nano Server.

#### Requirements

* Target machine must have access to the DISM PowerShell module

#### Parameters

* **[String] Name** _(Key)_: The name of the package to install or uninstall.
* **[String] Ensure** _(Required)_: Specifies whether the package should be installed or uninstalled. To install the package, set this property to Present. To uninstall the package, set the property to Absent. { *Present* | Absent }.
* **[String] SourcePath** _(Required)_: The path to the cab file to install or uninstall the package from.
* **[String] LogPath** _(Write)_: The path to a file to log the operation to. There is no default value, but if not set, the log will appear at %WINDIR%\Logs\Dism\dism.log.

#### Read-Only Properties from Get-TargetResource

None

#### Examples

* [Install a cab file with the given name from the given path](https://github.com/PowerShell/PSDesResources/blob/master/Examples/Sample_WindowsPackageCab.ps1)

## Versions

### Unreleased

* Adding WindowsFeature resource/tests/example

### 2.0.0.0

* Initial release of PSDscResources
