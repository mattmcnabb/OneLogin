$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginGroup" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod { New-GroupMock }

        It "outputs a group object" {
            Get-OneLoginGroup -Identity 13579 | Should BeOfType [OneLogin.Group]
        }

        Context "-Identity" {
            Mock Invoke-OneLoginRestMethod -ParameterFilter {$Body.ContainsKey("id")} -MockWith {$null} -Verifiable

            It "passes 'id' as and API query" {
                Get-OneloginGroup -Identity '12345'
                Assert-VerifiableMocks
            }
        }

        Context "API Error handling" {
            Mock Invoke-OneLoginRestMethod { New-GroupMock -InvalidProperties}

            It "throws if API returns unknown properties" {
                {Get-OneloginGroup} | Should Throw
            }
        }

        Context "Error handling" {
            Mock Invoke-OneLoginRestMethod { throw }
            
            It "throws a non-terminating error" {
                Test-TerminatingError {Get-OneLoginGroup} | Should Be $false
            }
        }
    }
}
