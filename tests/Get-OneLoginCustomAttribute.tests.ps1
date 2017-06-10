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

Describe "Get-OneLoginCustomAttribute" {
    InModuleScope "OneLogin" {
        Mock Invoke-RestMethod { New-CustomAttributeMock }

        It "outputs string values" {
            Get-OneLoginCustomAttribute | Should BeOfType [System.String]
        }

        It "outputs an array" {
            (Get-OneLoginCustomAttribute).Count | Should Be 2
        }
    }
}
