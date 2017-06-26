$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Set-OneLoginUserCustomAttribute" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod {$null}
        Mock Get-OneLoginCustomAttribute {"nuffin", "whatev"}
        Mock Get-OneLoginUser {[OneLogin.User](New-UserMock)}
        $User = Get-OneLoginUser -Identity '12345'

        $Splat = @{
            Confirm = $false
            ErrorAction = "Stop"
        }

        It "accepts a user object via the pipeline" {
            {$User | Set-OneLoginUserCustomAttribute -CustomAttributes @{nuffin = 'nuffin'} @Splat} | Should Not Throw
        }

        It "doesn't accept other objects via the pipeline" {
            {'string' | Set-OneLoginUserCustomAttribute -CustomAttributes @{nuffin = 'nuffin'} @Splat} | Should Throw
            {[PSCustomObject]@{nuffin = "nuffin"} |
                Set-OneLoginUserCustomAttribute -CustomAttributes @{nuffin = 'nuffin'} @Splat} |
                Should Throw
        }

        It "validates attribute values" {
            {$User | Set-OneLoginUserCustomAttribute -CustomAttributes @{nuffin = $null}} | Should Throw
        }

        It "validates custom attribute names" {
            {$User | Set-OneLoginUserCustomAttribute -CustomAttributes @{garbage = "trash"}} | Should Throw
        }
    }

    $TestCases = @(
        @{MetadataValue = "ConfirmImpact"; Result = "Medium"},
        @{MetadataValue = "SupportsShouldProcess"; Result = $true}
    )
    It 'has a <MetadataValue> value of <Result>' -TestCases $TestCases {
        param ($MetadataValue, $Result)
        (Get-CommandMetadata "Set-OneLoginUserCustomAttribute").$MetadataValue | Should Be $Result
    }
}
