$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginRole" {
    InModuleScope "OneLogin" {
        Mock Invoke-RestMethod { New-RoleMock }

        It "outputs a group object" {
            Get-OneLoginRole -Identity 86442 | Should BeOfType [OneLogin.Role]
        }
    }
}
