﻿[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '')]
param ()

if ($PSVersionTable.PSVersion.Major -lt 5 -or $PSVersionTable.PSVersion.Minor -lt 1)
{
    Write-Warning -Message 'Cannot run PSDscResources integration tests on PowerShell versions lower than 5.1'
    return
}

Import-Module -Name (Join-Path -Path (Split-Path -Path $PSScriptRoot -Parent) `
                               -ChildPath (Join-Path -Path 'TestHelpers' `
                                                     -ChildPath 'CommonTestHelper.psm1'))

$script:testEnvironment = Enter-DscResourceTestEnvironment `
    -DscResourceModuleName 'PSDscResources' `
    -DscResourceName 'MSFT_GroupResource' `
    -TestType 'Integration'

try
{
    Describe 'Group Integration Tests'  {
        BeforeAll {
            Import-Module -Name (Join-Path -Path (Join-Path -Path (Split-Path -Path $PSScriptRoot -Parent) `
                                                            -ChildPath 'TestHelpers') `
                                           -ChildPath 'MSFT_GroupResource.TestHelper.psm1')

            $script:confgurationWithMembersFilePath = Join-Path -Path $PSScriptRoot `
                                                                -ChildPath 'MSFT_GroupResource_Members.config.ps1'
            $script:confgurationWithMembersToIncludeExcludeFilePath = Join-Path -Path $PSScriptRoot `
                                                                                -ChildPath 'MSFT_GroupResource_MembersToIncludeExclude.config.ps1'
        }

        It 'Should use Group from PSDscResources' {
            $groupResource = Get-DscResource -Name 'Group'

            $groupResource | Should Not Be $null

            if ($groupResource.Count -gt 1)
            {
                $sortedGroupResrources = $groupResource | Sort-Object -Property 'Version' -Descending
                $groupResource = $sortedGroupResrources | Select-Object -First 1
            }

            $groupResource.ModuleName | Should Be 'PSDscResources'
        }

        It 'Should create an empty group' {
            $configurationName = 'CreateEmptyGroup'
            $testGroupName = 'TestEmptyGroup1'

            $resourceParameters = @{
                Ensure = 'Present'
                GroupName = $testGroupName
            }

            Test-GroupExists -GroupName $testGroupName | Should Be $false

            try
            {
                { 
                    . $script:confgurationWithMembersFilePath -ConfigurationName $configurationName
                    & $configurationName -OutputPath $TestDrive @resourceParameters
                    Start-DscConfiguration -Path $TestDrive -ErrorAction 'Stop' -Wait -Force
                } | Should Not Throw

                Test-GroupExists -GroupName $testGroupName | Should Be $true
            }
            finally
            {
                if (Test-GroupExists -GroupName $testGroupName)
                {
                    Remove-Group -GroupName $testGroupName
                }
            }
        }

        It 'Should create a group with two test users using Members' {
            $configurationName = 'CreateGroupWithTwoMembers'
            $testGroupName = 'TestGroupWithMembers2'

            $username1 = 'TestUser1'
            $username2 = 'TestUser2'

            $testPassword = 'T3stPassw0rd#'
            $secureTestPassword = ConvertTo-SecureString -String $testPassword -AsPlainText -Force

            $testUserCredential1 = New-Object -TypeName 'System.Management.Automation.PSCredential' -ArgumentList @( $username1, $secureTestPassword )
            $testUserCredential2 = New-Object -TypeName 'System.Management.Automation.PSCredential' -ArgumentList @( $username2, $secureTestPassword )

            $user1 = New-User -Credential $testUserCredential1
            $user2 = New-User -Credential $testUserCredential2

            $resourceParameters = @{
                Ensure = 'Present'
                GroupName = $testGroupName
                Members = @( $username1, $username2 )
            }

            Test-GroupExists -GroupName $testGroupName | Should Be $false

            try
            {
                { 
                    . $script:confgurationWithMembersFilePath -ConfigurationName $configurationName
                    & $configurationName -OutputPath $TestDrive @resourceParameters
                    Start-DscConfiguration -Path $TestDrive -ErrorAction 'Stop' -Wait -Force
                } | Should Not Throw

                Test-GroupExists -GroupName $testGroupName | Should Be $true
            }
            finally
            {
                if (Test-GroupExists -GroupName $testGroupName)
                {
                    Remove-Group -GroupName $testGroupName
                }

                Remove-User -UserName $username1
                Remove-User -UserName $username2
            }
        }

        It 'Should add a member to a group with MembersToInclude' {
            $configurationName = 'CreateGroupWithTwoMembers'
            $testGroupName = 'TestGroupWithMembersToInclude3'

            $username1 = 'TestUser1'

            $testPassword = 'T3stPassw0rd#'
            $secureTestPassword = ConvertTo-SecureString -String $testPassword -AsPlainText -Force

            $testUserCredential1 = New-Object -TypeName 'System.Management.Automation.PSCredential' -ArgumentList @( $username1, $secureTestPassword )

            $user1 = New-User -Credential $testUserCredential1

            $resourceParameters = @{
                Ensure = 'Present'
                GroupName = $testGroupName
                MembersToInclude = @( $username1 )
            }

            Test-GroupExists -GroupName $testGroupName | Should Be $false

            New-Group -GroupName $testGroupName

            Test-GroupExists -GroupName $testGroupName | Should Be $true

            try
            {
                { 
                    . $script:confgurationWithMembersToIncludeExcludeFilePath -ConfigurationName $configurationName
                    & $configurationName -OutputPath $TestDrive @resourceParameters
                    Start-DscConfiguration -Path $TestDrive -ErrorAction 'Stop' -Wait -Force
                } | Should Not Throw

                Test-GroupExists -GroupName $testGroupName | Should Be $true
            }
            finally
            {
                if (Test-GroupExists -GroupName $testGroupName)
                {
                    Remove-Group -GroupName $testGroupName
                }

                Remove-User -UserName $username1
            }
        }

        It 'Should remove a member from a group with MembersToExclude' {
            $configurationName = 'CreateGroupWithTwoMembers'
            $testGroupName = 'TestGroupWithMembersToInclude3'

            $username1 = 'TestUser1'

            $testPassword = 'T3stPassw0rd#'
            $secureTestPassword = ConvertTo-SecureString -String $testPassword -AsPlainText -Force

            $testUserCredential1 = New-Object -TypeName 'System.Management.Automation.PSCredential' -ArgumentList @( $username1, $secureTestPassword )

            $user1 = New-User -Credential $testUserCredential1

            $resourceParameters = @{
                Ensure = 'Present'
                GroupName = $testGroupName
                MembersToExclude = @( $username1 )
            }

            Test-GroupExists -GroupName $testGroupName | Should Be $false

            New-Group -GroupName $testGroupName -MemberUserNames @( $username1 )

            Test-GroupExists -GroupName $testGroupName | Should Be $true

            try
            {
                { 
                    . $script:confgurationWithMembersToIncludeExcludeFilePath -ConfigurationName $configurationName
                    & $configurationName -OutputPath $TestDrive @resourceParameters
                    Start-DscConfiguration -Path $TestDrive -ErrorAction 'Stop' -Wait -Force
                } | Should Not Throw

                Test-GroupExists -GroupName $testGroupName | Should Be $true
            }
            finally
            {
                if (Test-GroupExists -GroupName $testGroupName)
                {
                    Remove-Group -GroupName $testGroupName
                }

                Remove-User -UserName $username1
            }
        }
    }
}
finally
{
    Exit-DscResourceTestEnvironment -TestEnvironment $script:testEnvironment
}
