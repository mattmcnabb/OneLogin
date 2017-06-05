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

Describe "Get-OneLoginEvent" {
    InModuleScope "OneLogin" {
        It "accepts multiple filter properties" {
            Mock -CommandName Invoke-RestMethod -MockWith {[PSCustomObject]@{Data = $null}}
            { Get-OneLoginEvent -Filter @{user_id = "123456"; directory_id = "56789" } } | Should Not Throw
        }
    }
}