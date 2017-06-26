$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "New-OneLoginUser" {
    InModuleScope $ModuleName {
        Mock Invoke-OneLoginRestMethod {New-UserMock}

        $Splat = @{
            firstname = "Matt"
            lastname  = "McNabb"
            email     = "matt@domain.com"
            username  = "matt"
        }

        It "outputs a user object" {
            New-OneLoginUser @Splat | Should BeOfType [OneLogin.User]
        }

        Context "Parameter values" {
            Mock Invoke-OneLoginRestMethod -ParameterFilter {$Body.ContainsKey("title")} -MockWith {$null} -Verifiable

            It "passes parameter values into the API query" {
                New-OneLoginUser @Splat -title "Vice President"
                Assert-VerifiableMocks
            }
        }
    }

    $TestCases = @(
        @{MetadataValue = "ConfirmImpact"; Result = "Medium"},
        @{MetadataValue = "SupportsShouldProcess"; Result = $true}
    )
    It 'has a <MetadataValue> value of <Result>' -TestCases $TestCases {
        param ($MetadataValue, $Result)
        (Get-CommandMetadata "New-OneLoginUser").$MetadataValue | Should Be $Result
    }
}
