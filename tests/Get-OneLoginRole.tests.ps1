$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginRole" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod { New-RoleMock }

        It "outputs a group object" {
            Get-OneLoginRole -Identity 86442 | Should BeOfType [OneLogin.Role]
        }

        It "validates filter properties" {
            {Get-OneLoginRole -Filter @{nuffin = "nuffin"}} | Should Throw
            {Get-OneLoginRole -Filter @{name = "Sales"}} | Should Not Throw
        }

        It "validates filter values" {
            {Get-OneLoginRole -Filter @{name = $null}} | Should Throw
        }

        It "requires a parameter" {
            {Get-OneLoginRole} | Should Throw
        }

        Context "-Identity" {
            Mock Invoke-OneLoginRestMethod -ParameterFilter {$Body.ContainsKey("id")} -MockWith {New-RoleMock} -Verifiable

            It "passes 'id' into the API query" {
                Get-OneloginRole -Identity "12345"
                Assert-VerifiableMock
            }
        }

        Context "-All" {
            Mock Invoke-OneLoginRestMethod -ParameterFilter {$Body -eq $null} -MockWith {New-RoleMock} -Verifiable

            It "passes 'id' into the API query" {
                Get-OneloginRole -All
                Assert-VerifiableMock
            }
        }

        Context "-Filter" {
            Mock Invoke-OneLoginRestMethod -ParameterFilter {$Body.ContainsKey("name")} -MockWith {New-RoleMock} -Verifiable

            It "passes a filter into the API query" {
                Get-OneloginRole -Filter @{name = "Sales"}
                Assert-VerifiableMock
            }
        }

        Context "Error handling" {
            Mock Invoke-OneLoginRestMethod { throw }
            
            It "throws a non-terminating error" {
                Test-TerminatingError {Get-OneLoginRole -All} | Should Be $false
            }
        }
    }
}
