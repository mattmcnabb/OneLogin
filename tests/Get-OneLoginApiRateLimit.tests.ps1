$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginApiRateLimit" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod { New-ApiRateLimitMock }

        It "returns a rate limit object" {
            Get-OneLoginApiRateLimit | Should BeOfType "OneLogin.ApiRateLimit"
        }

        Context "Error handling" {
            Mock -CommandName Invoke-OneLoginRestMethod -MockWith { New-ApiRateLimitMock -InvalidProperties}

            It "throws if API returns unknown properties" {
                {Get-OneloginEvent -filter @{user_id = "12345"}} | Should Throw
            }
        }
    }
}
