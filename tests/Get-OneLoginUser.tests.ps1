$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginUser" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod { New-UserMock }

        It "accepts multiple filter properties" {
            { Get-OneLoginUser -Filter @{firstname = "Matt"; email = "matt@domain.com" } } | Should Not Throw
        }

        It "outputs a user object" {
            Get-OneLoginUser -Identity 12345 | Should BeOfType [OneLogin.User]
        }

        It "calculates status value" {
            (Get-OneLoginUser -Identity 12345).status_value | Should Be "Active"
        }

        It "validates filter properties" {
            {Get-OneLoginUser -Filter @{nuffin = "nuffin"}} | Should Throw
            {Get-OneLoginUser -Filter @{firstname = "matt"}} | Should Not Throw
        }

        It "validates filter values" {
            {Get-OneLoginUser -Filter @{firstname = $null}} | Should Throw
        }

        It "requires a parameter" {
            {Get-OneLoginUser} | Should Throw
        }

        Context "-Identity" {
            Mock Invoke-OneLoginRestMethod -ParameterFilter {$Body.ContainsKey("id")} -MockWith {$null} -Verifiable

            It "passes 'id' into the API query" {
                Get-OneloginUser -Identity "12345"
                Assert-VerifiableMocks
            }
        }

        Context "-All" {
            Mock Invoke-OneLoginRestMethod -ParameterFilter {$Body -eq $null} -MockWith {$null} -Verifiable

            It "passes 'id' into the API query" {
                Get-OneloginUser -All
                Assert-VerifiableMocks
            }
        }

        Context "-Filter" {
            Mock Invoke-OneLoginRestMethod -ParameterFilter {$Body.ContainsKey("firstname")} -MockWith {$null} -Verifiable

            It "passes a filter into the API query" {
                Get-OneloginUser -Filter @{firstname = "Matt"}
                Assert-VerifiableMocks
            }
        }

        Context "API Error handling" {
            Mock -CommandName Invoke-OneLoginRestMethod -MockWith { New-UserMock -InvalidProperties}

            It "throws if API returns unknown properties" {
                {Get-OneloginUser -Identity '12345'} | Should Throw
            }
        }

        Context "Error handling" {
            Mock Invoke-OneLoginRestMethod { throw }
            
            It "throws a non-terminating error" {
                Test-TerminatingError {Get-OneLoginUser -All} | Should Be $false
            }
        }
    }
}
