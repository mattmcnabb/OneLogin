if ($env:APPVEYOR)
{
    $ModuleName = $env:Appveyor_Project_Name
}
else
{
    $ProjectPath = Split-Path $PSScriptRoot
    $MocksPath = Join-Path $PSScriptRoot "mocks"
    $ModuleName = Split-Path $ProjectPath -Leaf
}

$ModulePath = Join-Path $ProjectPath $ModuleName
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
