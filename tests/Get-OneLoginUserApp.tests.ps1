$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginUserApp" {
    InModuleScope $ModuleName {
        Mock Invoke-RestMethod { New-AppMock }
        Mock Get-OneLoginUser { [OneLogin.User](New-UserMock).Data }
        $User = Get-OneLoginUser -Identity '12345'
        
        It "outputs a group object" {
            Get-OneLoginUserApp -Identity $User | Should BeOfType [OneLogin.App]
        }
    }
}
