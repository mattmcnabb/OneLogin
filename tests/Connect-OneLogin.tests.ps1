$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Connect-OneLogin" {
    InModuleScope "OneLogin" {
        Mock Invoke-RestMethod { New-ConnectionMock }

        It "creates a token in the module scope" {
            Connect-OneLogin -Credential (New-PSCredentialMock) -region us
            $Token | Should Not BeNullOrEmpty
        }
    }

    It "token is not available outside of module scope" {
        $Token | Should BeNullOrEmpty
    }
}
