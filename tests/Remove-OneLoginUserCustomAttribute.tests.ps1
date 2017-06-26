$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Remove-OneLoginUserCustomAttribute" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod {$null}
        Mock Get-OneLoginCustomAttribute {"nuffin", "whatev"}
        Mock Get-OneLoginUser {[OneLogin.User](New-UserMock)}
        $User = Get-OneLoginUser -Identity '12345'

        $Splat = @{
            Confirm     = $false
            ErrorAction = "Stop"
        }

        It "accepts a user object via the pipeline" {
            {$User | Remove-OneLoginUserCustomAttribute -CustomAttributes 'nuffin' @Splat} | Should Not Throw
        }

        It "doesn't accept other objects via the pipeline" {
            {'string' | Remove-OneLoginUserCustomAttribute -CustomAttributes 'nuffin' @Splat} | Should Throw
            {[PSCustomObject]@{nuffin = "nuffin"} |
                Remove-OneLoginUserCustomAttribute -CustomAttributes 'nuffin' @Splat} |
                Should Throw
        }

        It "validates custom attribute names" {
            {$User | Remove-OneLoginUserCustomAttribute -CustomAttributes "garbage"} | Should Throw
        }
    }

    $TestCases = @(
        @{MetadataValue = "ConfirmImpact"; Result = "High"},
        @{MetadataValue = "SupportsShouldProcess"; Result = $true}
    )
    It 'has a <MetadataValue> value of <Result>' -TestCases $TestCases {
        param ($MetadataValue, $Result)
        (Get-CommandMetadata "Remove-OneLoginUserCustomAttribute").$MetadataValue | Should Be $Result
    }
}
