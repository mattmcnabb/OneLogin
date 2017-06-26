$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Add-OneLoginUserRole" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod { $null }
        Mock Get-OneLoginUser { [OneLogin.User](New-UserMock) }
        $User = Get-OneLoginUser -Identity '12345'

        It "accepts a user object via the pipeline" {
            {$User | Add-OneLoginUserRole -RoleId '12345' -Confirm:$false -ErrorAction Stop} | Should Not Throw
        }

        It "doesn't accept other objects via the pipeline" {
            {'string' | Add-OneLoginUserRole -RoleId '12345' -Confirm:$false -ErrorAction Stop} | Should Throw
            {[PSCustomObject]@{nuffin = "nuffin"} | Add-OneLoginUserRole -RoleId '12345' -Confirm:$false -ErrorAction Stop} | Should Throw
        }
    }

    $TestCases = @(
        @{MetadataValue = "ConfirmImpact"; Result = "Medium"},
        @{MetadataValue = "SupportsShouldProcess"; Result = $true}
    )
    It 'has a <MetadataValue> value of <Result>' -TestCases $TestCases {
        param ($MetadataValue, $Result)
        (Get-CommandMetadata "Add-OneLoginUserRole").$MetadataValue | Should Be $Result
    }
}