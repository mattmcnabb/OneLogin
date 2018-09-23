$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-OneLoginUserApp" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod { New-AppMock }
        Mock Get-OneLoginUser { [OneLogin.User](New-UserMock) }
        $User = Get-OneLoginUser -Identity '12345'
        
        It "outputs an app object" {
            Get-OneLoginUserApp -Identity $User | Should BeOfType [OneLogin.App]
        }

        Context "Error handling" {
            Mock Invoke-OneLoginRestMethod { throw }
            
            It "throws a non-terminating error" {
                Test-TerminatingError {$User | Get-OneLoginUserApp} | Should Be $false
            }
        }
    }
}
