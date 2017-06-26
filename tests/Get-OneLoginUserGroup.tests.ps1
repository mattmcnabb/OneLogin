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

        Context "Error handling" {
            Mock -CommandName Invoke-OneLoginRestMethod -MockWith { New-GroupMock -InvalidProperties}

            It "throws if API returns unknown properties" {
                {Get-OneloginEvent -filter @{user_id = "12345"}} | Should Throw
            }
        }
    }
}
