$errorActionPreference = 'Stop'
Set-StrictMode -Version 'Latest'

if ($PSVersionTable.PSVersion.Major -lt 5 -or $PSVersionTable.PSVersion.Minor -lt 1)
{
    Write-Warning -Message 'Cannot run PSDscResources integration tests on PowerShell versions lower than 5.1'
    return
}

# Import CommonTestHelper for Enter-DscResourceTestEnvironment, Exit-DscResourceTestEnvironment
$script:moduleRootPath = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent
$script:testFolderPath = Split-Path -Path $PSScriptRoot -Parent
$script:testHelpersPath = Join-Path -Path $script:testFolderPath -ChildPath 'TestHelpers'
Import-Module -Name (Join-Path -Path $script:testHelpersPath -ChildPath 'CommonTestHelper.psm1')

$script:testEnvironment = Enter-DscResourceTestEnvironment `
    -DscResourceModuleName 'PSDscResources' `
    -DscResourceName 'MSFT_ScriptResource' `
    -TestType 'Integration'

try
{
    Describe 'Script Integration Tests' {
        BeforeAll {
            # Import Script module for Get-TargetResource, Test-TargetResource
            $dscResourcesFolderFilePath = Join-Path -Path $script:moduleRootPath -ChildPath 'DscResources'
            $scriptResourceFolderFilePath = Join-Path -Path $dscResourcesFolderFilePath -ChildPath 'MSFT_ScriptResource'
            $scriptResourceModuleFilePath = Join-Path -Path $scriptResourceFolderFilePath -ChildPath 'MSFT_ScriptResource.psm1'
            Import-Module -Name $scriptResourceModuleFilePath

            $script:configurationNoCredentialFilePath = Join-Path -Path $PSScriptRoot -ChildPath 'MSFT_ScriptResource_NoCredential.config.ps1'
            $script:configurationWithCredentialFilePath = Join-Path -Path $PSScriptRoot -ChildPath 'MSFT_ScriptResource_WithCredential.config.ps1'

            # Cannot use $TestDrive here because script is run outside of Pester
            $script:testFilePath = Join-Path -Path $env:SystemDrive -ChildPath 'TestFile.txt'

            if (Test-Path -Path $script:testFilePath)
            {
                Remove-Item -Path $script:testFilePath -Force
            }
        }

        AfterAll {
            if (Test-Path -Path $script:testFilePath)
            {
                Remove-Item -Path $script:testFilePath -Force
            }
        }

        Context 'Get, set, and test scripts specified and Credential not specified' {
            if (Test-Path -Path $script:testFilePath)
            {
                Remove-Item -Path $script:testFilePath -Force
            }

            $configurationName = 'TestScriptNoCredential'

            # Cannot use $TestDrive here because script is run outside of Pester
            $resourceParameters = @{
                FilePath = $script:testFilePath
                FileContent = 'Test file content' 
            }

            It 'Should have removed test file before config runs' {
                Test-Path -Path $resourceParameters.FilePath | Should Be $false
            }

            It 'Should compile and apply the MOF without throwing' {
                { 
                    . $script:configurationNoCredentialFilePath -ConfigurationName $configurationName
                    & $configurationName -OutputPath $TestDrive @resourceParameters
                    Start-DscConfiguration -Path $TestDrive -ErrorAction 'Stop' -Wait -Force
                } | Should Not Throw
            }

            It 'Should have created the test file' {
                Test-Path -Path $resourceParameters.FilePath | Should Be $true
            }

            It 'Should have set file content correctly' {
                Get-Content -Path $resourceParameters.FilePath -Raw | Should Be "$($resourceParameters.FileContent)`r`n"
            }
        }

        Context 'Get, set, and test scripts specified and Credential specified' {
            if (Test-Path -Path $script:testFilePath)
            {
                Remove-Item -Path $script:testFilePath -Force
            }

            $configurationName = 'TestScriptWithCredential'
            
            # Cannot use $TestDrive here because script is run outside of Pester
            $resourceParameters = @{
                FilePath = $script:testFilePath
                FileContent = 'Test file content'
                Credential = Get-AppVeyorAdministratorCredential
            }

            It 'Should have removed test file before config runs' {
                Test-Path -Path $resourceParameters.FilePath | Should Be $false
            }

            $configData = @{
                AllNodes = @(
                    @{
                        NodeName = 'localhost'
                        PSDscAllowPlainTextPassword = $true
                        PSDscAllowDomainUser = $true
                    }
                )
            }

            It 'Should compile and apply the MOF without throwing' {
                { 
                    . $script:configurationWithCredentialFilePath -ConfigurationName $configurationName
                    & $configurationName -OutputPath $TestDrive -ConfigurationData $configData @resourceParameters
                    Start-DscConfiguration -Path $TestDrive -ErrorAction 'Stop' -Wait -Force
                } | Should Not Throw
            }

            It 'Should have created the test file' {
                Test-Path -Path $resourceParameters.FilePath | Should Be $true
            }

            It 'Should have set file content correctly' {
                Get-Content -Path $resourceParameters.FilePath -Raw | Should Be "$($resourceParameters.FileContent)`r`n"
            }
        }
    }
}
finally
{
    Exit-DscResourceTestEnvironment -TestEnvironment $script:testEnvironment
}
