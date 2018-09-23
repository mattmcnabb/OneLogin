$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Set-OneLoginUser" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod {$null}
        Mock Get-OneLoginUser {[OneLogin.User](New-UserMock)}
        $User = Get-OneLoginUser -Identity '12345'

        It "accepts a user object via the pipeline" {
            {$User | Set-OneLoginUser -Confirm:$false -ErrorAction Stop} | Should Not Throw
        }

        It "doesn't accept other objects via the pipeline" {
            {'string' | Set-OneLoginUser -Confirm:$false -ErrorAction Stop} | Should Throw
            {[PSCustomObject]@{nuffin = "nuffin"} | Set-OneLoginUser -Confirm:$false -ErrorAction Stop} | Should Throw
        }

        Context "Parameter values" {
            Mock Invoke-OneLoginRestMethod -ParameterFilter {$Body.ContainsKey("title")} -MockWith {$null} -Verifiable

            It "passes parameter values into the API query" {
                $User | Set-OneLoginUser -title "Vice President"
                Assert-VerifiableMock
            }
        }
    }

    $TestCases = @(
        @{MetadataValue = "ConfirmImpact"; Result = "Medium"},
        @{MetadataValue = "SupportsShouldProcess"; Result = $true}
    )
    It 'has a <MetadataValue> value of <Result>' -TestCases $TestCases {
        param ($MetadataValue, $Result)
        (Get-CommandMetadata "Set-OneLoginUser").$MetadataValue | Should Be $Result
    }
}
