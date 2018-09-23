$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Connect-OneLogin" {
    InModuleScope $ModuleName {
        Mock Invoke-RestMethod {New-ConnectionMock}

        $Splat = @{
            Region = "us"
            Credential = (New-PSCredentialMock)
        }

        It "creates a token in the module scope" {
            Connect-OneLogin @Splat
            $Token | Should Not BeNullOrEmpty
        }
    }

    It "token is not available outside of module scope" {
        $Token | Should BeNullOrEmpty
    }
}
