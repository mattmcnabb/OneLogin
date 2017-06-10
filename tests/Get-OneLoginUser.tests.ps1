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

Describe "Get-OneLoginUser" {
    InModuleScope "OneLogin" {
        Mock Invoke-RestMethod { New-UserMock }

        It "accepts multiple filter properties" {
            { Get-OneLoginUser -Filter @{firstname = "Matt"; email = "matt@domain.com" } } | Should Not Throw
        }

        It "returns a user object" {
            Get-OneLoginUser -Identity 12345 | Should BeOfType [OneLogin.User]
        }

        It "calculates status value" {
            (Get-OneLoginUser -Identity 12345).status_value | Should Be "Active"
        }
    }
}
