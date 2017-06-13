$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginUserRole" {
    InModuleScope $ModuleName {
        Mock Invoke-RestMethod { New-RoleMock }
        Mock Get-OneLoginUser { [OneLogin.User](New-UserMock).Data }
        $User = Get-OneLoginUser -Identity '12345'

        It "returns a role object" {
            Get-OneLoginUserRole -Identity $User | Should BeOfType [OneLogin.Role]
        }
    }
}
