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
                Assert-VerifiableMock
            }
        }

        Context "Put method" {
            Mock Invoke-RestMethod {$null} -ParameterFilter {$Body.GetType().Name -eq "string"} -Verifiable

            It "passes a json body" {
                Invoke-OneLoginRestMethod -Endpoint 'api/users' -Body @{} -Method Put
                Assert-VerifiableMock
            }
        }

        Context "Post method" {
            Mock Invoke-RestMethod {$null} -ParameterFilter {$Body.GetType().Name -eq "string"} -Verifiable

            It "passes a json body" {
                Invoke-OneLoginRestMethod -Endpoint 'api/users' -Body @{} -Method Post
                Assert-VerifiableMock
            }
        }

        Context "Del method" {
            Mock Invoke-RestMethod {$null} -ParameterFilter {$Body.GetType().Name -eq "string"} -Verifiable

            It "passes a json body" {
                Invoke-OneLoginRestMethod -Endpoint 'api/users' -Body @{} -Method Del
                Assert-VerifiableMock
            }
        }
        
        Context "Body" {
            Mock Invoke-RestMethod {$null} -ParameterFilter {$Body -eq $null} -Verifiable

            It "passes a json body" {
                Invoke-OneLoginRestMethod -Endpoint 'api/users'
                Assert-VerifiableMock
            }
        }

        Context "Pagination" {
            Mock -CommandName Invoke-RestMethod -MockWith {New-RestMock} -ParameterFilter {$Body.after_cursor}
            Mock -CommandName Invoke-RestMethod -MockWith {New-RestMock -Link} -ParameterFilter {!$Body.after_cursor}

            It "paginates data" {
                $null = Invoke-OneLoginRestMethod -Endpoint "https://api.us.onelogin.com/api/1"
                Assert-MockCalled Invoke-RestMethod -Times 2 -Exactly
            }
        }
    }
}
