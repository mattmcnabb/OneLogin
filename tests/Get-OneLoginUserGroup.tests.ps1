$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginUserGroup" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod { New-GroupMock }
        Mock Get-OneLoginUser { [OneLogin.User](New-UserMock) }
        $User = Get-OneLoginUser -Identity '12345'

        It "outputs a group object" {
            Get-OneLoginUserGroup -Identity $User | Should BeOfType [OneLogin.Group]
        }
    }
}
