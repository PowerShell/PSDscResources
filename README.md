# PSDscResources

PSDscResources is the new home of the in-box resources from PSDesiredStateConfiguration.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Contributing
Please check out common DSC Resources [contributing guidelines](https://github.com/PowerShell/DscResource.Kit/blob/master/CONTRIBUTING.md).

## Resources
* [WindowsOptionalFeature](#windows-optional-feature): Provides a mechanism to enable or disable optional features on a target node.
* [WindowsPackageCab](#windows-package-cab): Provides a mechanism to install or uninstall a package from a windows cabinet (cab) file on a target node.

### Resources that work on Nano Server

* [WindowsOptionalFeature](#windows-optional-feature)
* [WindowsPackageCab](#windows-package-cab)

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

* [Install a cab file with the given name from the given path](https://github.com/PowerShell/xPSDesiredStateConfiguration/blob/dev/Examples/Sample_xWindowsPackageCab.ps1)


### Unreleased

### 2.0.0.0

* Initial release of PSDscResources