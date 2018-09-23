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

        Context "Additional Properties" {
            Mock -CommandName Invoke-OneLoginRestMethod -MockWith { New-ApiRateLimitMock -UnknownProperties}

            It "adds additional properties returned by the API" {
                (Get-OneLoginApiRateLimit).AdditionalProperties | Should Not Be Null
            }
        }
    }
}
