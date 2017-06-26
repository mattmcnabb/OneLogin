$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Remove-OneLoginUserRole" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod { $null }
        Mock Get-OneLoginUser { [OneLogin.User](New-UserMock) }
        $User = Get-OneLoginUser -Identity '12345'

        It "accepts a user object via the pipeline" {
            {$User | Remove-OneLoginUserRole -RoleId '12345' -Confirm:$false -ErrorAction Stop} | Should Not Throw
        }

        It "doesn't accept other objects via the pipeline" {
            {'string' | Remove-OneLoginUserRole -RoleId '12345' -Confirm:$false -ErrorAction Stop} | Should Throw
            {[PSCustomObject]@{nuffin = "nuffin"} | Remove-OneLoginUserRole -RoleId '12345' -Confirm:$false -ErrorAction Stop} | Should Throw
        }
    }

    $TestCases = @(
        @{MetadataValue = "ConfirmImpact"; Result = "High"},
        @{MetadataValue = "SupportsShouldProcess"; Result = $true}
    )
    It 'has a <MetadataValue> value of <Result>' -TestCases $TestCases {
        param ($MetadataValue, $Result)
        (Get-CommandMetadata "Remove-OneLoginUserRole").$MetadataValue | Should Be $Result
    }
}
