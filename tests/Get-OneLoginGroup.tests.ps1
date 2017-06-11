$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginGroup" {
    InModuleScope "OneLogin" {
        Mock Invoke-RestMethod { New-GroupMock }

        It "outputs a group object" {
            Get-OneLoginGroup -Identity 13579 | Should BeOfType [OneLogin.Group]
        }
    }
}
