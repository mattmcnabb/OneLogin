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
        It "accepts multiple filter properties" {
            Mock -CommandName Invoke-RestMethod -MockWith {[PSCustomObject]@{Data = $null}}
            { Get-OneLoginUser -Filter @{firstname = "Matt"; email = "matt@domain.com" } } | Should Not Throw
        }

        It "returns a user object" {
            
        }
    }
}
