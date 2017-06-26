$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginUserRole" {
    InModuleScope $ModuleName {
        Mock Get-OneLoginUser { [OneLogin.User](New-UserMock) }
        Mock Get-OneLoginRole {$null} -Verifiable
        $User = Get-OneLoginUser -Identity '12345'

        It "returns correct number of roles" {
            $User | Get-OneLoginUserRole
            Assert-MockCalled -CommandName Get-OneLoginRole -Times $User.role_id.count
        }
    }
}
