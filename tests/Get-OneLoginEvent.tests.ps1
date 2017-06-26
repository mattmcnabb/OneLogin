$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginEvent" {
    InModuleScope $ModuleName {
            Mock Invoke-OneLoginRestMethod {New-EventMock}

            It "accepts multiple filter properties" {
                {Get-OneLoginEvent -Filter @{user_id = "123456"; directory_id = "56789"}} | Should Not Throw
            }

            It "outputs an event object" {
                Get-OneLoginEvent -Filter @{user_id = "123456"} | Should BeOfType [OneLogin.Event]
            }

            It "validates filter properties" {
                {Get-OneLoginEvent -Filter @{nuffin = "nuffin"}} | Should Throw
                {Get-OneLoginEvent -Filter @{user_id = "12345"}} | Should Not Throw
            }

            It "validates filter values" {
                {Get-OneLoginEvent -Filter @{user_id = $null}} | Should Throw
            }

            It "requires -filter or -since" {
                {Get-OneLoginEvent} | Should Throw
            }
        
        Context "Since/Until" {
            Mock Invoke-OneLoginRestMethod -ParameterFilter {$Body.ContainsKey("Since")} -MockWith {$null} -Verifiable

            It "passes 'since' as and API query" {
                Get-OneloginEvent -Since (Get-Date).Date
                Assert-VerifiableMocks
            }
        }

        Context "API Error handling" {
            Mock Invoke-OneLoginRestMethod { New-EventMock -InvalidProperties}

            It "throws if API returns unknown properties" {
                {Get-OneloginEvent -filter @{user_id = "12345"}} | Should Throw
            }
        }

        Context "Error handling" {
            Mock Invoke-OneLoginRestMethod { throw }
            
            It "throws a non-terminating error" {
                Test-TerminatingError {Get-OneLoginEvent -Filter @{user_id = "12345"}} | Should Be $false
            }
        }
    }
}
