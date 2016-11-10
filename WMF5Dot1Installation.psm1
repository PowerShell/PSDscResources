Set-StrictMode -Version 'latest'
$errorActionPreference = 'Stop'

<#
    .SYNOPSIS
        Retuns the URL for downloading the WMF 5.1 installation file for Windows 8.1(x86) and Windows Server 2012 R2(amd64).
#>
function Get-Wmf5Dot1InstallFileUrl
{
    [OutputType([String])]
    [CmdletBinding()]
    param ()
    
    if ($env:PROCESSOR_ARCHITECTURE.Contains('64'))
    {
        return 'https://download.microsoft.com/download/7/C/7/7C7943DE-DACB-40A7-BDBA-59CB10E05348/Win8.1AndW2K12R2-KB3156422-x64.msu'
    }
    else
    {
        return 'https://download.microsoft.com/download/7/C/7/7C7943DE-DACB-40A7-BDBA-59CB10E05348/Win8.1-KB3156422-x86.msu'
    }
}

<#
    .SYNOPSIS
        Downloads the WMF 5.1 installation file to the given location.

    .PARAMETER DownloadLocation
        The file path to download the WMF 5.1 install file to.
#>
function Download-Wmf5Dot1InstallFile
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $DownloadLocation
    )

    $wmf5Dot1InstallFileUrl = Get-Wmf5Dot1InstallFileUrl

    Invoke-WebRequest -Uri $wmf5Dot1InstallFileUrl -OutFile $DownloadLocation
}

<#
    .SYNOPSIS
        Invokes WUSA to install the given file.
        Outputs the exit code from WUSA.
    
    .PARAMETER InstallFile
        The file to install using WUSA.

    .NOTES
        WUSA: Windows Update Service Application
#>
function Invoke-Wusa
{
    [OutputType([Int])]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $InstallFile
    )

    Write-Verbose -Message "Installing $InstallFile..."

    $wusaProcess = [System.Diagnostics.Process]::Start('wusa.exe', "/quiet /norestart $InstallFile")

    # Wait for 60 minutes for the process to exit
    if (-not $wusaProcess.WaitForExit(60 * 60 * 1000))
    { 
        throw "Installing $InstallFile timed out after 60 minutes. Exiting..."
    }

    Write-Verbose -Message ('Install completed (wusa.exe exit code: 0x{0:x})' -f $process.ExitCode)
   
    return $process.ExitCode
}

<#
    .SYNOPSIS
        Installs WMF 5.1.
        Outputs the exit code from WUSA.
#>
function Install-Wmf5Dot1
{
    [OutputType([Int])]
    [CmdletBinding()]
    param ()

    $downloadLocation = "$env:SystemDrive\WMF5Dot1.msu"

    $downloadLocation = Download-Wmf5Dot1InstallFile -DownloadLocation $downloadLocation
    
    Write-Verbose -Message 'Restarting The Windows Update service (wuauserv)...'

    Set-Service -Name 'wuauserv' -StartupType 'Manual'
    Start-Service -Name 'wuauserv'

    Write-Verbose -Message 'Installing WMF 5.1...'

    $wusaExitCode = Invoke-Wusa -InstallFile $downloadLocation
    
    return $wusaExitCode
}

Export-ModuleMember -Function @( 'Install-Wmf5Dot1' )
