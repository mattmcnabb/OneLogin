$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "ConvertTo-OneLoginObject" {
    InModuleScope $ModuleName {
        $TypeName = "Convert.Test"
        Add-ConversionType -TypeName $TypeName
        $Type = [Type]$TypeName

        It "doesn't throw an error" {
            {$Object = New-ConversionMock -NumberOfProperties 3 |
                ConvertTo-OneLoginObject -OutputType $Type} | Should Not Throw
        }

        It "outputs an object of type $TypeName" {
            $Object = New-ConversionMock -NumberOfProperties 3 |
                    ConvertTo-OneLoginObject -OutputType $Type | Should BeOfType $Type
        }

        It "add additional properties" {
            $Object = New-ConversionMock -NumberOfProperties 3 |
                ConvertTo-OneLoginObject -OutputType $Type
            $Object.AdditionalProperties | Should Not BeNullOrEmpty
        }

        $TestCases = @(
            @{NumberOfProperties = 3},
            @{NumberOfProperties = 4}
        )
        It "builds an object with <NumberOfProperties> properties" -TestCases $TestCases {
            param ($NumberOfProperties)
            $Object = New-ConversionMock -NumberOfProperties $NumberOfProperties |
                ConvertTo-OneLoginObject -OutputType $Type
            
            $Object.AdditionalProperties.Keys.Count | Should Be ($NumberOfProperties - 2)
        }
    }
}
