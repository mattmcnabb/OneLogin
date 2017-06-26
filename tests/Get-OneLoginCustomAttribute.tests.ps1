$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginCustomAttribute" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod { New-CustomAttributeMock }

        It "outputs string values" {
            Get-OneLoginCustomAttribute | Should BeOfType [System.String]
        }

        It "outputs an array" {
            (Get-OneLoginCustomAttribute).Count | Should Be 2
        }
    }
}
