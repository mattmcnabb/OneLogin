$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginApiRateLimit" {
    InModuleScope "OneLogin" {
        Mock Invoke-RestMethod { New-ApiRateLimitMock }

        It "returns a rate limit object" {
            Get-OneLoginApiRateLimit | Should BeOfType "OneLogin.ApiRateLimit"
        }
    }
}
