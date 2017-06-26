$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Invoke-OneLoginRestMethod" {
    InModuleScope $ModuleName {
        Mock Invoke-RestMethod {throw}

        It "throws a terminating error" {
            {Invoke-OneLoginRestMethod -Endpoint "api/users"} | Should Throw
        }

        Context "Get method" {
            Mock Invoke-RestMethod {$null} -ParameterFilter {$Body.GetType().Name -eq "Hashtable"} -Verifiable

            It "passes a hashtable body" {
                Invoke-OneLoginRestMethod -Endpoint 'api/users' -Body @{}
                Assert-VerifiableMocks
            }
        }

        Context "Put method" {
            Mock Invoke-RestMethod {$null} -ParameterFilter {$Body.GetType().Name -eq "string"} -Verifiable

            It "passes a json body" {
                Invoke-OneLoginRestMethod -Endpoint 'api/users' -Body @{} -Method Put
                Assert-VerifiableMocks
            }
        }

        Context "Post method" {
            Mock Invoke-RestMethod {$null} -ParameterFilter {$Body.GetType().Name -eq "string"} -Verifiable

            It "passes a json body" {
                Invoke-OneLoginRestMethod -Endpoint 'api/users' -Body @{} -Method Post
                Assert-VerifiableMocks
            }
        }

        Context "Del method" {
            Mock Invoke-RestMethod {$null} -ParameterFilter {$Body.GetType().Name -eq "string"} -Verifiable

            It "passes a json body" {
                Invoke-OneLoginRestMethod -Endpoint 'api/users' -Body @{} -Method Del
                Assert-VerifiableMocks
            }
        }
        
        Context "Body" {
            Mock Invoke-RestMethod {$null} -ParameterFilter {$Body -eq $null} -Verifiable

            It "passes a json body" {
                Invoke-OneLoginRestMethod -Endpoint 'api/users'
                Assert-VerifiableMocks
            }
        }
    }
}
